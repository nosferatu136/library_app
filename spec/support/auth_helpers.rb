module AuthHelpers
  def auth_headers_for(user)
    post "/login", params: {
      user: { email: user.email, password: "password123" }
    }
    token = JSON.parse(response.body)["token"]
    { "Authorization" => "Bearer #{token}" }
  end

  def rswag_auth_token_for(user)
    post "/login", params: {
      user: { email: user.email, password: "password123" }
    }
    JSON.parse(response.body)["token"]
  end
end
