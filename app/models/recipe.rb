class Recipe < ApplicationRecord
  has_many :ingridients, dependent: :destroy
  has_many :instructions, dependent: :destroy
  validates :title, :description, presence: true
end
