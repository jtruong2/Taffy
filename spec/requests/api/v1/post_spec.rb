require 'rails_helper'

RSpec.describe "Post API", :type => :request do

  context "POST /api/v1/user/:id/post" do
    it "creates a new post" do
      user = create(:user)
      params = { post: { text_content: "Hello" } }
      post "/api/v1/user/#{user.id}/post", params: params

      output = JSON.parse(response.body)

      expect(response).to be_success
      expect(output['text_content']).to eq('Hello')
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

  context "PATCH /api/v1/user/:id/post/:post_id" do
    it "updates a post content" do
      user = create(:user)
      post = create(:post, user_id: user.id)
      params = { post: { text_content: "Updated Content" } }

      patch "/api/v1/user/#{user.id}/post/#{post.id}", params: params

      output = JSON.parse(response.body)

      expect(response).to be_success
      expect(output['text_content']).to eq('Updated Content')
    end
  end

  context "DELETE /api/v1/user/:id/post/:post_id" do
    it "deletes a post" do
      user = create(:user)
      post = create(:post, user_id: user.id)

      delete "/api/v1/user/#{user.id}/post/#{post.id}"

      output = JSON.parse(response.body)

      expect(response).to be_success
      expect(user.posts.count).to eq(0)
    end
  end

  context "POST /api/v1/user/:id/post/:post_id/like" do
    it "adds / deletes a user's like to a post" do
      author = create(:user)
      reader = create(:user)
      post = create(:post, user_id: author.id)

      #get initial like count
      get "/api/v1/user/#{author.id}/post/#{post.id}"

      first_output = JSON.parse(response.body)

      expect(first_output['likes']).to eq(0)

      #add like to a post
      params = { like: { reader_id: reader.id } }

      post "/api/v1/user/#{author.id}/post/#{post.id}/like", params: params

      expect(response).to be_success

      #get counr after adding like
      get "/api/v1/user/#{author.id}/post/#{post.id}"

      second_output = JSON.parse(response.body)

      expect(second_output['likes']).to eq(1)

      #get count after removing like
      delete "/api/v1/user/#{author.id}/post/#{post.id}/like", params: params

      get "/api/v1/user/#{author.id}/post/#{post.id}"

      third_output = JSON.parse(response.body)

      expect(third_output['likes']).to eq(0)
    end
  end

  context "GET /api/v1/user/:id/post/:post_id/check_like" do
    it "returns true if user liked post" do
      author = create(:user)
      reader = create(:user)
      post = create(:post, user_id: author.id)
      like = Like.create(user_id: reader.id, post_id: post.id)
      params = { like: { reader_id: reader.id } }

      get "/api/v1/user/#{author.id}/post/#{post.id}/check_like", params: params

      first_output = JSON.parse(response.body)

      expect(response).to be_success
      expect(first_output['is_liked']).to eq('true')

      delete "/api/v1/user/#{author.id}/post/#{post.id}/like", params: params

      get "/api/v1/user/#{author.id}/post/#{post.id}/check_like", params: params

      second_output = JSON.parse(response.body)

      expect(response).to be_success
      expect(second_output['is_liked']).to eq('false')
    end
  end
end