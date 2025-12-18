require 'swagger_helper'

RSpec.describe "Books API", type: :request do
  let(:librarian) { create(:user, :librarian) }
  let(:member)    { create(:user, :member) }
  let(:book)      { create(:book) }
  let(:token)         { rswag_auth_token_for(member) }
  let(:Authorization) { "Bearer #{token}" }

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

  describe "GET /search", type: :request do
    let!(:book1) { create(:book, title: "Harry Potter", author: "J.K. Rowling") }
    let!(:book2) { create(:book, title: "Lord of the Rings", author: "Tolkien") }

    it "returns books matching the search query" do
      headers = auth_headers_for(member)
      get "/books/search", params: { q: "harry" }, headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.length).to eq(1)
      expect(json.first["title"]).to eq("Harry Potter")
    end

    it "returns empty array when no results" do
      headers = auth_headers_for(member)
      get "/books/search", params: { q: "xyz" }, headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([])
    end
  end

   path '/books' do
    get 'List all books' do
      security [{ bearerAuth: [] }]
      tags 'Books'
      produces 'application/json'
      
      response '200', 'Retrieve all books' do
        schema type: :array,
        items: {
          type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            author: { type: :string },
            available: { type: :boolean },
            quantity: { type: :integer },
            created_at: { type: :string, format: 'date-time' },
            updated_at: { type: :string, format: 'date-time' }
          },
          required: ['id', 'title', 'author', 'available', 'quantity']
        }
        
        run_test!
      end
    end
  end
end
