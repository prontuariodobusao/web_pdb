class User < ApplicationRecord
  has_secure_password

  validates :name, :identity, presence: true

  validates :identity, uniqueness: true

  validates :password,
            length: { minimum: 6 },
            confirmation: true,
            format: {
              with: VALID_PASSWORD_REGEX,
              message: I18n.t('errors.messages.password_format')
            }

  validates :password_confirmation,
            presence: true

  def locked?
    return true unless locked_at.nil?

    false
  end
end
