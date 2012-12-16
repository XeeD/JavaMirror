require "java"

class JarReader
  def initialize(path_to_jar)
    @path_to_jar = path_to_jar
    require path_to_jar
  end

  def each_class
    Zippy.open(@path_to_jar).each do |zipped_file|
      if zipped_file =~ /\.class$/
        next if zipped_file =~ /\$\d+\.class/
        next if zipped_file =~ /\$/
        begin
          klass = ClassInJar.new(zipped_file)
          klass.constantize
          yield klass
        rescue NameError => e
          p e
        end
      end
    end
  end

  def classes
    classes = []
    each_class { |zipfile| classes << zipfile }
    classes
  end

  class ClassInJar
    attr_reader :name, :filename

    def initialize(filename)
      match_data = filename.match /(?:(.+)\/)?([^\/]+)\.class$/
      if match_data
        @package_path = match_data[1]
        @name = match_data[2]
        @filename = filename
      end
    end

    def constantize
      unless @klass
        class_in_module = package_with_class.
            join(".")

        puts "Java.#{class_in_module}"
        @klass = eval "Java.#{class_in_module}"
      end

      @klass
    end

    def java_class
      constantize.java_class
    end

    def package
      package_with_class.join(".")
    end

    def package_with_class
      @package_path.split("/") + class_name
    end

    def class_name
      name.split("$")
    end

    def declared_instance_methods
      java_class.declared_instance_methods
    end
  end
end
