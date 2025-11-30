module Librarian
  class DashboardController < ApplicationController
    before_action :authenticate_user!

    def index
      authorize! :manage, :all
      # total books, total borrowed books, books due today, and a list of members with overdue books.
      total_books = Book.count
      total_active_borrowings = Borrowing.active.count
      books_due_today = Book.joins(:borrowings).merge(Borrowing.due_today).distinct
      overdue_members = Borrowing.overdue.includes(:user).map(&:user).uniq

      render json: {
        total_books: total_books,
        total_borrowed_books: total_active_borrowings,
        books_due_today: books_due_today,
        overdue_members: overdue_members
      }
    end
  end
end
