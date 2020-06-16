class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.regex_valid_email

  before_save :downcase_email

  validates :name, presence: true,
                   length: { maximum: Settings.users.user_name.maximum }
  validates :email, presence: true,
                    length: { Settings.users.mail.maximum },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
