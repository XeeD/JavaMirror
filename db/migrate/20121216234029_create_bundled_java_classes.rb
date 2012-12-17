class CreateBundledJavaClasses < ActiveRecord::Migration
  def change
    create_table :bundled_java_classes do |t|
      t.string :name
      t.string :package
      t.string :location_in_jar
      t.integer :jar_file_id

      t.timestamps
    end
  end
end
