class CreateSecrets < ActiveRecord::Migration
  def change
    create_table :secrets do |t|
      t.string :title
      t.boolean :published
      t.string :description
      t.integer :user_id

      t.timestamps
    end
    add_index :secrets, :user_id
  end
end
