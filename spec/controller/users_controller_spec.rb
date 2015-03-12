require 'rails_helper'
require 'pp'

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    it "returns json of all users" do
      user = create_user
      get :index
      expect(response.status).to be(200)
      response_array = JSON.parse(response.body)["users"]
      expect(response_array[0]["first_name"]).to eq(user.first_name)
    end
  end

  describe "#show" do
    it "returns json of user" do
      user1 = create_user
      user2 = create_user

      get :show, id: user1
      expect(response.status).to be(200)
      response_array = JSON.parse(response.body)
      expect(response_array["user"]["first_name"]).to eq(user1.first_name)

      get :show, id: user2
      response_array = JSON.parse(response.body)
      expect(response_array["user"]["first_name"]).to eq(user2.first_name)
    end
  end

  describe "#update" do
    it "returns json of updated user" do
      user = create_user
      patch :update, id: user, user: {email: 'new@email.com'}
      expect(response.status).to be(200)
      response_array = JSON.parse(response.body)
      expect(response_array["user"]["email"]).to eq('new@email.com')
    end
  end

  describe "#destroy" do
    it "returns json of deleted user" do
      user1 = create_user
      delete :destroy, id: user1
      expect(response.status).to be(200)
      response_array = JSON.parse(response.body)
      expect(response_array).to eq("users"=>[])
    end
  end

end
