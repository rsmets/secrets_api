require 'spec_helper'

describe Api::V1::SecretsController do
  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      @secret = FactoryGirl.create :secret, user: @user
      api_authorization_header @user.auth_token
      get :show, id: @secret.id
    end

    it "returns the information about a reporter on a hash" do
      secret_response = json_response
      expect(secret_response[:title]).to eql @secret.title
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @secret_attributes = FactoryGirl.attributes_for :secret
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, secret: @secret_attributes }
      end

      it "renders the json representation for the secret record just created" do
        secret_response = json_response
        expect(secret_response[:title]).to eql @secret_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_secret_attributes = { title: "My deepest secret", description: "I stole a wrench from a monkey." }
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, secret: @invalid_secret_attributes }
      end

      it "renders an errors json" do
        secret_response = json_response
        expect(secret_response).to have_key(:errors)
      end

    end
  end


  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @secret = FactoryGirl.create :secret, user: @user
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @secret.id,
              secret: { title: "An expensive TV" } }
      end

      it "renders the json representation for the updated user" do
        secret_response = json_response
        expect(secret_response[:title]).to eql "An expensive TV"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @secret.id,
              secret: { description: "I actually stole from a zebra too." } }
      end

      it "renders an errors json" do
        secret_response = json_response
        expect(secret_response).to have_key(:errors)
      end

  
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @secret = FactoryGirl.create :secret, user: @user
      api_authorization_header @user.auth_token
      delete :destroy, { user_id: @user.id, id: @secret.id }
    end

    it { should respond_with 204 }
  end

end
