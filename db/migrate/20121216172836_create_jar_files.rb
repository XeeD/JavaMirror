class CreateJarFiles < ActiveRecord::Migration
  def change
    create_table :jar_files do |t|
      t.string :name
      t.binary :data

      t.timestamps
    end
  end
end
