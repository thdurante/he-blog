FactoryGirl.define do
  factory :post do
    content { Faker::Lorem.paragraph }
    user nil
  end
end
