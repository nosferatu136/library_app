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
      can :search, Book

      # Borrowing actions
      can :create, Borrowing  # borrow a book
      can :read, Borrowing, user_id: user.id
      # Dashboard access
      can :read, :dashboard
    end
  end
end
