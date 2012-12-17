class ClassReflector
  attr_reader :java_class

  def initialize(klass)
    @klass = klass
  end

  def java_class
    @klass.java_class
  end

  def instance_methods
    java_class.declared_instance_methods
  end

  def inherited_instance_methods
    java_class.java_instance_methods - instance_methods
  end

  def inherited_class_methods
    java_class.java_class_methods - class_methods
  end

  def class_methods
    java_class.declared_class_methods
  end

  def inner_classes
    java_class.declared_classes.map { |klass| klass.to_s.gsub(/^.+\$/, "") }
  end

  def self.from_bundled_java_class(bundled_java_class)
    bundled_java_class.require_jar
    klass = eval "Java.#{bundled_java_class.canonical_name}"
    new(klass)
  end

  def method_missing(*params)
    java_class.send(*params)
  end
end
