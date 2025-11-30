require "rails_helper"

RSpec.describe "Librarian Dashboard", type: :request do
  let(:librarian) { create(:user, :librarian) }

  describe "GET /librarian/dashboard" do
    it "allows any logged-in user to list books" do
      headers = auth_headers_for(librarian)

      get "/librarian/dashboard", headers: headers
      expect(response).to have_http_status(:ok)
    end
  end
end
