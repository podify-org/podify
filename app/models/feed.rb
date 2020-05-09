class Feed < ApplicationModel
  many_to_one :user

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
    raise "Don't have a strategy to get requests for type '#{type}'" unless type == 'all'

    user.requests_dataset
  end

  def requests
    requests_dataset.all
  end
end
