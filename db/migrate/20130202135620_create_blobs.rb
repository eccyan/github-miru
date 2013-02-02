class CreateBlobs < ActiveRecord::Migration
  def change
    create_table :blobs do |t|
      t.integer :authentication_id
      t.string :branch
      t.string :head_sha
      t.string :repository_name
      t.string :path

      t.timestamps
    end
  end
end
