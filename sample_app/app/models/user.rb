class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.user.email.email_regex
  USERS_PARAMS = %i(name email password password_confirmation).freeze

  validates :name, presence: true,
    length: {maximum: Settings.user.name.max_length}
  validates :email, presence: true,
    length: {maximum: Settings.user.email.max_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.user.password.min_length}

  has_secure_password

  before_save :downcase_email

  private

  def downcase_email
    email.downcase!
  end
end
