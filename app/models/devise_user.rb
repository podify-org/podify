class DeviseUser < User
  self.raise_on_save_failure = false
  plugin :devise
  devise :database_authenticatable, :token_authenticatable, :registerable, :recoverable, :rememberable, :trackable # , :confirmable
end
