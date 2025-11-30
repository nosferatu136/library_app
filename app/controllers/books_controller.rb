class BooksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    render json: @books
  end

  def create
    if @book.save
      render json: @book, status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    head :no_content
  end

  def search
    authorize! :read, Book

    query = params[:q].to_s.strip

    @books = if query.present?
      Book.where("title ILIKE :q OR author ILIKE :q", q: "%#{query}%")
    else
      Book.none
    end

    render json: @books
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :available, :quantity)
  end
end
