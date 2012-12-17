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
          p klass
        end
      end
    end
  end

  def classes
    classes = []
    each_class { |zipfile| classes << zipfile }
    classes
  end
end
