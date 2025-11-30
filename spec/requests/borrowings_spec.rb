require "rails_helper"

RSpec.describe "Borrowings API", type: :request do
  let(:member) { create(:user, :member) }
  let(:book)   { create(:book, quantity: 1) }
  let(:headers) { auth_headers_for(member) }

  describe "POST /borrowings" do
    it "allows a member to borrow an available book" do
      post "/borrowings", headers: headers, params: { book_id: book.id }

      expect(response).to have_http_status(:created)
      expect(book.reload.available).to be(false)
    end
  end

  describe "PUT /borrowings/:id" do
    it "allows a member to return a book" do
      borrowing = create(:borrowing, user: member, book: book)
      book.update(available: false)

      put "/borrowings/#{borrowing.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(book.reload.available).to be(true)
    end
  end
end
