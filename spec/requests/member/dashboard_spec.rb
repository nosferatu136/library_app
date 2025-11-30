require "rails_helper"

RSpec.describe "Member Dashboard", type: :request do
  let(:member) { create(:user, :member) }

  describe "GET /member/dashboard" do
    it "allows any logged-in user to list books" do
      headers = auth_headers_for(member)

      get "/member/dashboard", headers: headers
      expect(response).to have_http_status(:ok)
    end
  end
end
