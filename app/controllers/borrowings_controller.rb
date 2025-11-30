class BorrowingsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    render json: @borrowings.where(user: current_user)
  end

  # Borrow
  def create
    book = Book.find(params[:book_id])

    return render json: { error: "Not available" }, status: :bad_request unless book.available?

    borrowing = Borrowing.create(user: current_user, book: book)
    book.decrease_quantity

    render json: borrowing, status: :created
  end

  # Return
  def update
    borrowing = Borrowing.find(params[:id])
    book_attributes = {}.tap do |attrs|
      attrs[:returned] = true if params[:returned]
    end
    borrowing.update(returned: true)
    borrowing.book.increase_quantity

    render json: borrowing
  end
end
