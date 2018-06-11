require 'rails_helper'

RSpec.describe "Post API", :type => :request do

  context "POST /api/v1/user/:id/post" do
    it "creates a new post" do
      user = create(:user)
      params = { post: { text_content: "Hello" } }
      post "/api/v1/user/#{user.id}/post", params: params

      output = JSON.parse(response.body)

      expect(response).to be_success
      expect(output['message']).to eq('Successful')
    end
  end

  context "GET /api/v1/user/:id/post/:post_id" do
    it "gets a specific post" do
      user = create(:user)
      post = create(:post, user_id: user.id)

      get "/api/v1/user/#{user.id}/post/#{post.id}"

      output = JSON.parse(response.body)

      expect(response).to be_success
      expect(output["text_content"]).to eq("Hello World")
      expect(output["alias_name"]).to eq(user.alias_name)
      expect(output["likes"]).to eq(0)
    end
  end

  context "GET /api/v1/user/:id/post" do
    it "gets all posts from a user" do
      user = create(:user)
      post = create(:post, user_id: user.id)
      post2 = create(:post, user_id: user.id)

      get "/api/v1/user/#{user.id}/post"

      output = JSON.parse(response.body)

      expect(response).to be_success
      expect(output.first['id']).to eq(post.id)
      expect(output.second['id']).to eq(post2.id)
      expect(output.count).to eq(2)
    end
  end
end