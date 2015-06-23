FactoryGirl.define do
  factory :goal do
    body { Faker::Lorem.sentence }
    user_id 1
    factory :public_goal do
      private_status false
    end
  end
end
