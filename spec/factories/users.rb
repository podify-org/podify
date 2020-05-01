FactoryBot.define do
  factory :user do
    email { generate(:email) }
  end

  sequence :email do |n|
    "#{n}@example.com"
  end
end
