class AddThiaminToIngredients < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredients, :thiamin_mg, :float
  end
end
