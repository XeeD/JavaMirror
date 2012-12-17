class BundledJavaClass < ActiveRecord::Base
  def generate_canonical_name
    [package, name].compact.join(".").to_s
  end
end

class AddCanonicalNameToBundledJavaClass < ActiveRecord::Migration
  def change
    add_column :bundled_java_classes, :canonical_name, :string
    add_index :bundled_java_classes, :canonical_name
    BundledJavaClass.scoped.each do |klass|
      klass.update_attribute(:canonical_name, klass.generate_canonical_name)
    end
  end
end
