class RemoveRiboflavinFromNutritionReqs < ActiveRecord::Migration[5.1]
  def change
    remove_column :nutrition_reqs, :riboflavin_g, :float
  end
end
