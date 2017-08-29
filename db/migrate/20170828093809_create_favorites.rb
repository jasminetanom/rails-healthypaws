class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :recipe_id

      t.timestamps
    end

    add_index :favorites, [:user_id, :recipe_id]
    add_foreign_key :favorites, :users, on_delete: :cascade
    add_foreign_key :favorites, :recipes, on_delete: :cascade
  end
end
