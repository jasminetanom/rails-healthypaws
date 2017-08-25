class ChangeRecipesIndex < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :recipes, :dogs

    add_foreign_key :recipes, :dogs, on_delete: :cascade
  end
end
