FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }

    trait :ready_for_login do
      password { "password" }
      confirmed_at { Time.current }
      confirmation_sent_at { Time.current }
      confirmation_token { SecureRandom.hex(8) }
    end
  end
end
