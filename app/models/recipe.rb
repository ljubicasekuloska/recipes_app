class Recipe < ApplicationRecord
  has_many :ingridients, dependent: :destroy
  accepts_nested_attributes_for :ingridients, allow_destroy: true

  has_many :instructions, dependent: :destroy

  validates :title, :description, presence: true
end
