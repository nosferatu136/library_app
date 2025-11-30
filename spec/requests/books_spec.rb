require "rails_helper"

RSpec.describe "Books API", type: :request do
  let(:librarian) { create(:user, :librarian) }
  let(:member)    { create(:user, :member) }
  let(:book)      { create(:book) }

  describe "GET /books" do
    it "allows any logged-in user to list books" do
      headers = auth_headers_for(member)

      get "/books", headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /books" do
    it "allows librarian to create a book" do
      headers = auth_headers_for(librarian)

      post "/books", headers: headers, params: {
        book: { title: "Test", author: "Author" }
      }

      expect(response).to have_http_status(:created)
    end

    it "prevents member from creating a book" do
      headers = auth_headers_for(member)

      post "/books", headers: headers, params: {
        book: { title: "Test", author: "Author" }
      }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
