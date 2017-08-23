class AddRiboflavinToNutritionReqs < ActiveRecord::Migration[5.1]
  def change
    add_column :nutrition_reqs, :riboflavin_mg, :float
  end
end
