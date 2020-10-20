require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
    describe "#POST create" do
        
        context "when is successfully created" do
            before(:each) do 
                user = FactoryBot.create :user
                @product_attributes = FactoryBot.attributes_for :product
                api_authorization_header user.auth_token
                post :create, params: {user_id: user.id, product: @product_attributes}
            end

            it 'renders a new product associated with a user' do
                product_response = json_response
                expect(product_response[:title]).to eql @product_attributes[:title]
            end

            it {should respond_with 201}

        end

        context "when item is not created" do
            before(:each) do
                @user = FactoryBot.create :user
                @prod_attrs = {title: "Some title", price: "not valid"}
                api_authorization_header @user.auth_token
                post :create, params: {user_id: @user.id, product: @prod_attrs }
            end

            it "renders errors as json" do
                prod_response = json_response
                expect(prod_response).to have_key(:errors)
            end

            it "provides the errors why it could not be created" do
                prod_response = json_response
                expect(prod_response[:errors][:price]).to include "is not a number"
            end

            it { should respond_with 422 }
        end
    end
end
