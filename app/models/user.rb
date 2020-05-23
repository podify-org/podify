class User < ApplicationModel
  one_to_many :requests
  many_to_many :sources, join_table: :requests
  one_to_many :feeds

  dataset_module do
    def by_email(email)
      first(email: email)
    end
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

  def after_create
    ensure_all_feed
  end

  def ensure_all_feed
    feeds_dataset.by_type(:all).first || Feed.create(
      user: self,
      name: 'All Downloads',
      type: 'all',
    )
  end

  def before_validation
    ensure_authentication_token
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
