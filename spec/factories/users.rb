FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    username { Faker::Internet.user_name }
    password { Faker::Internet.password }

    trait :with_avatar do
      avatar { Faker::Avatar.image }
    end

    trait :with_posts do
      transient do
        number_of_posts 5
      end

      after(:create) do |user, evaluator|
        create_list :post, evaluator.number_of_posts, user: user
      end
    end
  end
end
