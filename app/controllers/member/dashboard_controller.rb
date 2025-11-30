# frozen_string_literal: true

module Member
  class DashboardController < ApplicationController
    before_action :authenticate_user!

    def index
      # books they've borrowed, their due dates, and any overdue books
      borrowed_books = Borrowing.active.where(user: current_user).includes(:book)
      result = borrowed_books.each_with_object({ active: [], overdue: [] }) do |borrowing, hash|
        book_info = {
          book: borrowing.book,
          due_date: borrowing.created_at + 2.weeks
        }

        if book_info[:due_date] < Date.today
          hash[:overdue] << book_info
        else
          hash[:active] << book_info
        end
      end

      render json: result, status: :ok
    end
  end
end
