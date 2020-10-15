# spec/controllers/concerns/autheticable
require 'rails_helper'
class Authentication < ActionController::API
    include Authenticable
end

describe Authenticable do 
    #declare the instance
    let(:authentication) { Authentication.new }
    subject { authentication }
    #describe the test
    describe "#current_user" do
        #examples of each test( no each because just 1 example)
        before(:each) do
         @user = FactoryBot.create :user
         request.headers["Authorization"] = @user.auth_token
         authentication.stub(:request).and_return(request)
        end   
        
        it "returns the user from the authorization header" do
         expect(authentication.current_user.auth_token).to eql @user.auth_token
        end
    end

    describe "#authenticate  with_token" do 
        before do
            @user = FactoryBot.create :user
            authentication.stub(:current_user).and_return(nil)
            response.stub(:response_code).and_return(401)
            response.stub(:body).and_return({"errors" => "Not Authenticated" }.to_json)
            authentication.stub(:response).and_return(response)

        end
        it "renders a json error message" do
            expect(json_response[:errors]).to eql "Not Authenticated"
        end

        it { should respond_with 401 }
    end
end