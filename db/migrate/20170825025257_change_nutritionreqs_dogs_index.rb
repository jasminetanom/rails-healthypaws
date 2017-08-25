class ChangeNutritionreqsDogsIndex < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :nutrition_reqs, :dogs

    add_foreign_key :nutrition_reqs, :dogs, on_delete: :cascade
  end
end
