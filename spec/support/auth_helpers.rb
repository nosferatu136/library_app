module AuthHelpers
  def auth_headers_for(user)
    post "/login", params: {
      user: { email: user.email, password: "password123" }
    }
    token = JSON.parse(response.body)["token"]
    { "Authorization" => "Bearer #{token}" }
  end
end
