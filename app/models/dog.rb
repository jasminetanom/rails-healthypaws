class Dog < ApplicationRecord
  belongs_to :user
  has_one :nutrition_req, dependent: :destroy
  has_many :recipes, dependent: :destroy

  validates :user, :name, :weight, :activity_level, :life_stage, :body_condition_score, presence: true
  validates :name, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }, length: { minimum: 2, maximum: 20, too_long: "20 characters is the maximum allowed" }
  validates :body_condition_score, numericality: { only_integer: true, greater_than: 0, less_than: 6 }

  before_save :assign_multiplier

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
