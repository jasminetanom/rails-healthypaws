class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.float :energy_kcal
      t.float :protein_g
      t.float :fat_g
      t.float :fiber_g
      t.float :calcium_mg
      t.float :iron_mg
      t.float :magnesium_mg
      t.float :phosphorus_mg
      t.float :potassium_mg
      t.float :sodium_mg
      t.float :zinc_mg
      t.float :vitamin_c_mg
      t.float :thiamin_g
      t.float :riboflavin_g
      t.float :niacin_mg
      t.float :pyridoxine_mg
      t.float :folate_ug
      t.float :vitamin_b12_ug
      t.float :vitamin_a_iu
      t.float :vitamin_e_mg
      t.float :vitamin_d_iu
      t.float :vitamin_k_ug
      t.float :ca_p_ratio

      t.timestamps
    end
  end
end
