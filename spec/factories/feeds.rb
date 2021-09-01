FactoryBot.define do
  factory :feed do
    name { generate(:feed_name) }
  end

  sequence :feed_name do |n|
    "Feed #{n}"
  end
end
