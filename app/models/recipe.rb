class Recipe < ApplicationRecord
  belongs_to :dog
  has_many :doses, dependent: :destroy, inverse_of: :recipe
  has_many :ingredients, through: :doses
  has_many :favorites, dependent: :destroy
  validates :name, presence: :true
  validates :dog, presence: :true

  mount_uploader :photo, PhotoUploader

  acts_as_votable

  accepts_nested_attributes_for :doses, reject_if: :all_blank, allow_destroy: true
end



