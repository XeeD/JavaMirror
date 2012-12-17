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
      puts "Java.#{canonical_name}"
      @klass = eval "Java.#{canonical_name}"
    end

    @klass
  end

  def canonical_name
    package_with_class.join(".")
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
        name: name.to_s,
        package: package_name,
        canonical_name: canonical_name,
        location_in_jar: location_in_jar
    }
  end
end
