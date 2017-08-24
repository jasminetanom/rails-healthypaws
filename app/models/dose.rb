class Dose < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  validates :ingredient, presence: true
  validates :amount, numericality: { greater_than: 0 }
  # validates :unit, presence: true
end
