class Dog < ApplicationRecord
  belongs_to :user
  has_one :nutrition_req, dependent: :destroy
  has_many :recipes, dependent: :destroy

  validates :user, :name, :weight, :size, :activity_level, :life_stage, :body_condition_score, presence: true
  validates :body_condition_score, numericality: { only_integer: true, greater_than: 0, less_than: 6 }

  before_save :assign_multiplier

  after_create do
    reqs = get_reqs(self.weight, self.multiplier, self.life_stage)
    @nutrition_req = NutritionReq.new(dog: self)
    reqs.each do |nutrient, amount|
      @nutrition_req[nutrient] = amount
    end
    @nutrition_req.save!
  end

  mount_uploader :photo, PhotoUploader

  scope :activity_level, -> (activity_level) { where activity_level: activity_level }
  scope :is_sterilized, -> (is_sterilized) { where is_sterilized: is_sterilized }
  scope :life_stage, -> (life_stage) { where life_stage: life_stage }

  MULTIPLIERS = {
    "activity_level" => {
      "low" => 1.06, "medium" => 1.14, "high" => 1.31
    },
    "size" => {
      "large" => 1.00, "medium" => 1.13, "small" => 1.29
    },
    "is_sterilized" => {
      "true" => 1.16, "false" => 1.37
    },
    "life_stage" => {
      "adult" => 1.00, "senior" => 0.81, "puppy" => 2.45
    },
    "body_condition_score" => {
      "1" => 1.43, "2" => 1.18, "3" => 1.00, "4" => 0.87, "5" => 0.77
    }
  }

  private

  def get_reqs(weight, multiplier, life_stage)
    resting_energy_req = 70 * ((weight.to_f) ** 0.75)
    daily_energy_req = resting_energy_req * multiplier
    coeff = daily_energy_req / 1000
    if life_stage == "puppy"
      req = {
        energy_kcal: daily_energy_req,
        protein_g: coeff * 56.3,
        fat_g: coeff * 21.3,
        fiber_g: 0,
        calcium_mg: coeff * 3000,
        iron_mg: coeff * 22,
        magnesium_mg: coeff * 100,
        phosphorus_mg: coeff * 2500,
        potassium_mg: coeff * 1500,
        sodium_mg: coeff * 800,
        zinc_mg: coeff * 25,
        thiamin_mg: coeff * 0.56,
        riboflavin_mg: coeff * 1.3,
        niacin_mg: coeff * 3.4,
        pyridoxine_mg: coeff * 0.38,
        folate_ug: coeff * 54,
        vitamin_b12_ug: coeff * 7,
        vitamin_a_iu: coeff * 1250,
        vitamin_e_mg: coeff * 0.8 * 12.5,
        vitamin_d_iu: coeff * 125
      }
    else
      req = {
        energy_kcal: daily_energy_req,
        protein_g: coeff * 45.0,
        fat_g: coeff * 13.8,
        fiber_g: 0,
        calcium_mg: coeff * 1250,
        iron_mg: coeff * 10,
        magnesium_mg: coeff * 150,
        phosphorus_mg: coeff * 1000,
        potassium_mg: coeff * 1500,
        sodium_mg: coeff * 200,
        zinc_mg: coeff * 20,
        thiamin_mg: coeff * 0.56,
        riboflavin_mg: coeff * 1.3,
        niacin_mg: coeff * 3.4,
        pyridoxine_mg: coeff * 0.38,
        folate_ug: coeff * 54,
        vitamin_b12_ug: coeff * 7,
        vitamin_a_iu: coeff * 1250,
        vitamin_e_mg: coeff * 0.8 * 12.5,
        vitamin_d_iu: coeff * 125
      }
    end
    return req
  end

  def assign_multiplier
    self.multiplier = calculate_multiplier
  end

  def calculate_multiplier
    a_l_m = MULTIPLIERS["activity_level"][self.activity_level]
    s_m = MULTIPLIERS["size"][self.size]
    i_s_m = MULTIPLIERS["is_sterilized"][self.is_sterilized.to_s]
    l_s_m = MULTIPLIERS["life_stage"][self.life_stage]
    b_c_s_m = MULTIPLIERS["body_condition_score"][self.body_condition_score.to_s]

    return a_l_m * s_m * i_s_m * l_s_m * b_c_s_m
  end
end
