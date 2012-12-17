class ClassInJar
  attr_reader :name, :location_in_jar

  def initialize(location_in_jar)
    match_data = location_in_jar.match /(?:(.+)\/)?([^\/]+)\.class$/
    if match_data
      @package_path = match_data[1]
      @name = match_data[2]
      @location_in_jar = location_in_jar
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

  def class_reflector
    constantize.java_class
  end

  def package_name
    package.present? ? package.join(".") : nil
  end

  def package
    (@package_path && @package_path.split("/")) || []
  end

  def package_with_class
    package + class_name
  end

  def class_name
    name.split("$")
  end

  def to_hash
    {
        name: name,
        package: package_name,
        location_in_jar: location_in_jar
    }
  end
end
