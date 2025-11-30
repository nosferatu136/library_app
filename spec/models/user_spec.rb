require "rails_helper"

RSpec.describe User, type: :model do
  it { should define_enum_for(:role).with_values(librarian: 0, member: 1) }
  it { should validate_presence_of(:email) }
end