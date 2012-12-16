class JarFile < ActiveRecord::Base
  mount_uploader :data, JarUploader

  def classes
    JarReader.new(data.current_path).classes
  end
end
