require "rails_helper"
require "cancan/matchers"

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  context "when user is a librarian" do
    let(:user) { build(:user, :librarian) }

    it { should be_able_to(:manage, Book.new) }
    it { should be_able_to(:manage, Borrowing.new) }
  end

  context "when user is a member" do
    let(:user) { build(:user, :member) }

    it { should be_able_to(:read, Book.new) }
    it { should be_able_to(:create, Borrowing.new) }

    it "cannot manage books" do
      expect(ability).not_to be_able_to(:create, Book.new)
    end
  end
end
