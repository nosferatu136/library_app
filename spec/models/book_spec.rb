require "rails_helper"

RSpec.describe Book, type: :model do
  it { should have_many(:borrowings) }
  it { should have_many(:users).through(:borrowings) }
end
