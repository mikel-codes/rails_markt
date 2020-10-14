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
end