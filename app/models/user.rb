class User < ApplicationRecord
  has_many :articles
  has_secure_password

  before_save :make_email_downcase

  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum:3, maximum:25}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {maximum:105}, format: {with: VALID_EMAIL_REGEX}

  private

  def make_email_downcase
    self.email = email.downcase
  end
end