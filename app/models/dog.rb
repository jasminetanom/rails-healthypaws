class Dog < ApplicationRecord
  belongs_to :user
  has_one :nutrition_req, dependent: :destroy
  has_many :recipes, dependent: :destroy

  validates :user, :name, :weight, :activity_level, :is_sterilized, :life_stage, :body_condition_score, presence: true
  validates :name, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }, length: { minimum: 2, maximum: 20, too_long: "20 characters is the maximum allowed" }
  validates :body_condition_score, numericality: { only_integer: true, greater_than: 0, less_than: 6 }


  mount_uploader :photo, PhotoUploader

  scope :activity_level, -> (activity_level) { where activity_level: activity_level }
  scope :is_sterilized, -> (is_sterilized) { where is_sterilized: is_sterilized }
  scope :life_stage, -> (life_stage) { where life_stage: life_stage }
end
