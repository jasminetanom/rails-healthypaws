class RemoveCaPRatioFromIngredients < ActiveRecord::Migration[5.1]
  def change
    remove_column :ingredients, :ca_p_ratio, :float
  end
end
