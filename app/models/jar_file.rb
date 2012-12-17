class JarFile < ActiveRecord::Base
  mount_uploader :data, JarUploader

  # Associations
  has_many :bundled_java_classes

  # Validations
  validates :data, presence: true

  # Callbacks
  before_create :save_filename
  after_create :extract_classes

  def classes
    jar_reader.classes
  end

  def jar_reader
    @jar_reader ||= JarReader.new(data.current_path)
  end


  protected

  def save_filename
    self.name = data.file.filename
  end

  def extract_classes
    jar_reader.each_class do |klass|
      bundled_java_classes.create(klass.to_hash)
    end
  end
end
