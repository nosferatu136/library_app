# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.librarian?
      can :manage, :all  # full admin access
    else
      # Members can only read books
      can :read, Book

      # Borrowing actions
      can :create, Borrowing  # borrow a book
      can :update, Borrowing, user_id: user.id  # return a book
      can :read, Borrowing, user_id: user.id
    end
  end
end
