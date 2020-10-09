require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
    #before any example 'it clause do' set the request_header to identify api version
    before(:each) { request.headers['Accept'] = "application/vnd.market.v1"}

    #the get show action lets describe a test for it
    describe "GET #show" do
        #indicating the each example in the test in this description
        before(:each) do 
            @user = FactoryBot.create :user
            get :show, params: {id: @user.id, format: :json}
        end
        
        it "returns the information of a selected user by a hash" do
            user_response = JSON.parse(response.body, symbolize_names: true)
            expect(user_response[:email]).to eql @user.email
        end

        it { should respond_with 200 }
    end

    describe "POST #create" do
        context "user is successfully created" do
            before(:each) do 
                @user_attributes = FactoryBot.attributes_for :user
                post :create, params: {user: @user_attributes}, format: :json
            end
            it "renders then json representation for the user record just created" do
                user_response = JSON.parse(response.body, symbolize_names: true)
                expect(user_response[:email]).to eql @user_attributes[:email]
            end
            it { should respond_with 201 } 
        end

        context "user could not be created" do 
            before(:each) do
                @invalid_user_attrs = {password: "12345", password_confirmation: "12345"}
                post :create, params: {user: @invalid_user_attrs}, format: :json
            end
            
            it "renders the errors of invalid object based on attrs definition" do
                user_response = JSON.parse(response.body, symbolize_names: true)
                expect(user_response).to have_key(:errors)
            end
            
            it "renders the json error on why user could not be created" do
                user_response = JSON.parse(response.body, symbolize_names:true)
                expect(user_response[:errors][:email]).to include "can't be blank"
            end

            
            it { should respond_with 422 }
        end
    end

    describe "PUT/PATCH #update" do
        context "when is successfully  updated" do
            before(:each) do
                @user = FactoryBot.create :user
                patch :update, params: {
                    id: @user.id,
                    user: {email: ""},
                    format: :json
                }
            end

           # it "renders the json representation for the updated user" do
           #     user_response = JSON.parse(response.body, symbolize_names: true)
            #    expect(user_response[:email]).to eql @user.email
            #end
        end
    end

end
