class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.regex_valid_email
  USERS_PARAMS = %i(name email password password_confirmation).freeze
  before_save :downcase_email

  validates :name, presence: true,
                   length: { maximum: Settings.users.user_name.maximum }
  validates :email, presence: true,
                    length: { maximum: Settings.users.email.maximum },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true

  has_secure_password
  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end
  end

  private

  def downcase_email
    email.downcase!
  end
end
