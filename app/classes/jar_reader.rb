require "java"

class JarReader
  include Enumerable

  def initialize(path_to_jar)
    @path_to_jar = path_to_jar
    require path_to_jar
  end

  def each
    Zippy.open(@path_to_jar).each do |zipped_file|
      if zipped_file =~ /\.class$/
        next if zipped_file =~ /\$/

        begin
          klass = ClassInJar.new(zipped_file)
          klass.preload
          yield klass
        rescue NameError => e
          p e
          p klass
        end
      end
    end
  end

  def classes
    inject { |klass| classes << klass }
  end
end
