class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true, length: {
    minimum: Settings.name.length.minimum,
    maximum: Settings.name.length.maximum
  }
  validates :email, presence: true, uniqueness: {case_sensitive: false},
  length: {
    minimum: Settings.email.length.minimum,
    maximum: Settings.email.length.maximum
  }, format: {with: Settings.email.valid_regex}
  validates :password, presence: true, length: {
    minimum: Settings.password.length.minimum,
    maximum: Settings.password.length.maximum
  }

  has_secure_password

  private
  def downcase_email
    email.downcase!
  end
end
