FactoryBot.define do
  factory :borrowing do
    user
    book
    returned { false }
  end
end
