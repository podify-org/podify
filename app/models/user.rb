class User < ApplicationModel
  one_to_many :requests
  many_to_many :sources, join_table: :requests

  def before_validation
    ensure_authentication_token
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def ensure_authentication_token!
    ensure_authentication_token
    save
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
