class BundledJavaClass < ActiveRecord::Base
  belongs_to :jar_file

  def class_reflector
    @class_reflector ||= ClassReflector.from_bundled_java_class(self)
  end

  def class_in_package
    [package, name].compact.join(".")
  end
end
