class DeviseUser < User
  self.raise_on_save_failure = false
  plugin :devise
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :confirmable
end
