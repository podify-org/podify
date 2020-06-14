module UserAPI
  class Mutations::SignIn < Mutations::BaseMutation
    null true

    argument :email, String, required: true
    argument :password, String, required: true

    field :success, Boolean, null: false
    field :authentication_token, String, null: true

    def resolve(email:, password:)
      # TODO: move this to a service
      user = DeviseUser.by_email(email)
      return { success: false } unless user && user.valid_password?(password)

      return {
        success: true,
        authentication_token: user.authentication_token,
      }
    end
  end
end
