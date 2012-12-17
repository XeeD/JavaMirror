class BundledJavaClass < ActiveRecord::Base
  belongs_to :jar_file

  scope :in_jar, ->(jar_file_id) { where(jar_file_id: jar_file_id) }
  scope :with_canonical_name, ->(canonical_name) { where(canonical_name: canonical_name) }

  def class_reflector
    @class_reflector ||= ClassReflector.from_bundled_java_class(self)
  end

  def generate_canonical_name
    [package, name].compact.join(".")
  end

  def require_jar
    jar_file.jar_reader
  end
end
