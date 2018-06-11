require 'rails_helper'

RSpec.describe "User API", :type => :request do
  context "GET /api/v1/user/:id" do
    it "outputs a single user" do
      user = create(:user)

      get "/api/v1/user/#{user.id}"

      output = JSON.parse(response.body)

      expect(response).to be_success
      expect(output['id']).to eq(user.id)
      expect(output['email']).to eq(user.email)
      expect(output['alias_name']).to eq(user.alias_name)

    end
  end

  context "POST /api/v1/user" do
    it "creates a new user" do
      user = build(:user)
      params = { user: {alias_name: user.alias_name, email: user.email, password: user.password}}
      post "/api/v1/user", params: params

      output = JSON.parse(response.body)

      expect(response).to be_success
      expect(User.count).to eq(1)
      expect(User.first.email).to eq(user.email)
      expect(User.first.alias_name).to eq(user.alias_name)

    end

    it "save fails without password" do
      user = build(:user)
      params = { user: {alias_name: user.alias_name, email: user.email}}

      post "/api/v1/user", params: params

      output = JSON.parse(response.body)

      expect(User.count).to eq(0)
    end

    it "save fails without email" do
      user = build(:user)
      params = { user: {alias_name: user.alias_name, password: user.password}}

      post "/api/v1/user", params: params

      expect(User.count).to eq(0)
    end
  end

  context "PATCH /api/v1/user/:id" do
    it "updates alias" do
      user = create(:user)
      params = { user: {alias_name: "New Name"}}

      patch "/api/v1/user/#{user.id}", params: params

      expect(User.first.alias_name).to eq("New Name")
    end

    it "updates password" do
      user = create(:user)
      params = { user: {password: "New Password"}}

      patch "/api/v1/user/#{user.id}", params: params

      expect(response).to be_success
    end
  end

end
