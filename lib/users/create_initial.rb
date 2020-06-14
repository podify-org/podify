module Users
  class CreateInitial
    include Dry::Monads[:result, :do, :maybe]

    include Podify::Import[
      'users.create',
      'settings',
    ]

    def call
      params = {
        email: settings.initial_user_email,
        password: settings.initial_user_password,
      }

      return Success(nil) if params.compact.empty?

      User.db.transaction do
        User.dataset.lock('EXCLUSIVE')

        Maybe(User.by_email(settings.initial_user_email)).fmap do |existing|
          return Success(existing)
        end

        create.call(params).fmap do |user|
          return Success(user)
        end.or do |failure|
          return Failure("Failed creating the initial user: #{failure.errors.to_h.map { |*a| a.join(' ') }.join(', ')}")
        end
      end
    end
  end
end
