class User < ApplicationRecord
  has_secure_password

  validates :username, uniqueness: true, presence: true

  validates :password,
            length: { minimum: 6 },
            confirmation: true,
            format: {
              with: VALID_PASSWORD_REGEX,
              message: I18n.t('errors.messages.password_format')
            }

  validates :password_confirmation,
            presence: true

  belongs_to :employee

  def unlocked?
    locked_at.nil?
  end

  def confirmed?
    !confirmed_at.nil?
  end
end
