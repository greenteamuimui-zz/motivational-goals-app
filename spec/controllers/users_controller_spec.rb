require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "POST #create" do
    context "invalid params" do
      it "renders the sign up page" do
        post :create, user: {username: 'jack', password: ""}
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "valid params" do
      it "logins the user with valid username and password combination" do
        post :create, user: {username: 'jack', password: "7654321"}
        expect(response).to redirect_to(goals_url)
      end
    end
  end
end
