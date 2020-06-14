class DeviseUser < User
  self.raise_on_save_failure = false
  plugin :devise
  devise(*[
    :database_authenticatable, :token_authenticatable, :recoverable, :rememberable, :trackable,
    Podify::Container['settings'].enable_signup ? :registerable : nil,
  ].compact)
end
