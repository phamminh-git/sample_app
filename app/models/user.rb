class User < ApplicationRecord
  PARAMS = %i(name email password password_confirmation).freeze
  before_save :downcase_email
  before_create :create_activation_digest
  attr_accessor :remember_token, :activation_token

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
  }, allow_nil: true, if: :password

  has_secure_password

  class << self
    def digest string
      min_cost = ActiveModel::SecurePassword.min_cost
      cost = min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update remember_digest: nil
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  private
  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
