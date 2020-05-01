FactoryBot.define do
  factory :source do
    url { generate(:url) }
  end

  sequence :url do |n|
    "https://youtube.com/watch?v=#{n}"
  end
end
