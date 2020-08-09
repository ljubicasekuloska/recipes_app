class Recipe < ApplicationRecord
  has_many :ingridients, dependent: :destroy
  accepts_nested_attributes_for :ingridients, allow_destroy: true

  has_many :instructions, dependent: :destroy
  accepts_nested_attributes_for :instructions, allow_destroy: true

  validates :title, :description, presence: true
end
