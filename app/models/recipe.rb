class Recipe < ApplicationRecord
  belongs_to :dog
  has_many :doses, dependent: :destroy
  validates :name, presence: :true
  validates :dog, presence: :true
end
