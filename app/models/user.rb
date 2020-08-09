class User < ApplicationRecord
  MAXIMUM_LENGTH = 50
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_many :recipes, dependent: :destroy

  before_save :email_to_downcase

  validates :handle, presence: true, length: { maximum: MAXIMUM_LENGTH }
  validates :email, presence: true, length: { maximum: MAXIMUM_LENGTH },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :first_name, presence: true, length: { maximum: MAXIMUM_LENGTH }
  validates :last_name, presence: true, length: { maximum: MAXIMUM_LENGTH }

  private

  def email_to_downcase
    self.email = email.downcase
  end
end
