require 'dry/cli'

module CLI
  module Commands
    module User
      extend ActiveSupport::Concern

      included do
        option :email, type: :string, desc: 'Email of the user'
      end

      def selected_user(args)
        email = args.fetch(:email)

        ::User.by_email(email).tap do |user|
          unless user
            puts "Can't find user with email #{email}"
            exit 1
          end
        end
      end
    end
  end
end
