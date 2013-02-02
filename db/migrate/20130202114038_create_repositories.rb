class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.integer :authentication_id
      t.string :name
      t.string :branch
      t.string :head_sha

      t.timestamps
    end
  end
end
