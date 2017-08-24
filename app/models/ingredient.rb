class Ingredient < ApplicationRecord
    has_many :doses, dependent: :destroy
    validates :energy_kcal, :protein_g, :fat_g, :fiber_g, :calcium_mg, :iron_mg, :magnesium_mg, :phosphorus_mg, :potassium_mg, :sodium_mg, :zinc_mg, :thiamin_mg, :riboflavin_mg, :niacin_mg, :pyridoxine_mg, :folate_ug, :vitamin_b12_ug,:vitamin_a_iu, :vitamin_e_mg, :vitamin_d_iu, presence: true, numericality: true
end
