FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    available { true }
    quantity { rand(1..5) }
  end
end
