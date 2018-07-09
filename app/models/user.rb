class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :validatable

  before_save { self.username = username.downcase }
  after_create :update_access_token!

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: true, allow_nil: true

  private

    def update_access_token!
      self.access_token = "#{self.id}:#{Devise.friendly_token}"
      save
    end

    # Devise setups for username field
    def email_required?
      false
    end

    def email_changed?
      false
    end
end
