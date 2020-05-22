class Feed < ApplicationModel
  many_to_one :user
  one_to_many :requests

  dataset_module do
    def by_type(type)
      where(type: type.to_s)
    end

    def by_token(token)
      first(token: token)
    end

    def with_token!(token)
      first!(token: token)
    end
  end

  def before_validation
    self.token ||= Devise.friendly_token
    super
  end

  def requests_dataset
    case type
    when 'all'
      user.requests_dataset
    when 'manual'
      super
    else
      raise "Don't have a strategy to get requests for type '#{type}'"
    end
  end

  def requests
    requests_dataset.all
  end
end
