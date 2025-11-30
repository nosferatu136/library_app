require "rails_helper"

RSpec.describe "Borrowings API", type: :request do
  let(:member) { create(:user, :member) }
  let(:librarian) { create(:user, :librarian) }
  let(:book)   { create(:book, quantity: 1) }

  describe "POST /borrowings" do
    it "allows a member to borrow an available book" do
      headers = auth_headers_for(member)
      post "/borrowings", headers: headers, params: { book_id: book.id }

      expect(response).to have_http_status(:created)
      expect(book.reload.available).to be(false)
    end
  end

  describe "PUT /borrowings/:id" do
    it "allows a librarian to return a book" do
      borrowing = create(:borrowing, user: member, book: book)
      book.update(available: false)
      headers = auth_headers_for(librarian)
      put "/borrowings/#{borrowing.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(book.reload.available).to be(true)
    end
  end
end
