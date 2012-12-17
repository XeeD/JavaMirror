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
      @klass = eval "Java.#{canonical_name}"
    end

    @klass
  end

  def preload
    constantize
    nil
  end

  def canonical_name
    split_canonical_name.join(".")
  end

  def package_name
    split_package.present? ? split_package.join(".") : nil
  end

  def split_package
    (@package_path && @package_path.split("/")) || []
  end

  def split_canonical_name
    split_package + split_class_name
  end

  def split_class_name
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
