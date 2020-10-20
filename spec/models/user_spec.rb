require 'rails_helper'

RSpec.describe User, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}
  before {@user = FactoryBot.build :user}
  subject{ @user}

  it { should respond_to(:auth_token) }
  it { should validate_uniqueness_of(:auth_token) } 
  it { should have_many(:products) }

  describe "generate_authentication_token" do
    it "generates a unique token" do
      Devise.stub(:friendly_token).and_return "auniquetoken123" 
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "auniquetoken123"
    end

    it "generates another token when one already has been  taken" do
      existing_user = FactoryBot.create :user, auth_token: "auniquetoken123"
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end

  describe "#product association" do
    before  do
      @user.save
      3.times {FactoryBot.create :product, :user => @user }
    end
    it "#it destroys associated products on delete" do
      products = @user.products
      @user.destroy
      products.each {|p| expect(Product.find(p.id)).to raise_error ActiveRecord::RecordNotFound }
    end
    
  end

end
