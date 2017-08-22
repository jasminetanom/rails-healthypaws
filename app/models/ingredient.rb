class Ingredient < ApplicationRecord
    has_many :doses, dependent: :destroy
    validates :energy_kcal, :protein_g, :fat_g, :fiber_g, :calcium_mg, :iron_mg, :magnesium_mg, :phosphorus_mg, :potassium_mg, :sodium_mg, :zinc_mg, :vitamin_c_mg, :thiamin_g, :riboflavin_g, :niacin_mg, :pyridoxine_mg, :folate_ug, :vitamin_b12_ug,:vitamin_a_iu, :vitamin_e_mg, :vitamin_d_iu, :vitamin_k_ug, presence: true, numericality: true
end
