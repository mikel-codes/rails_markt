require 'rails_helper'

RSpec.describe Product, type: :model do
  it {should respond_to(:title)}
  it {should respond_to(:price)}
  it {should respond_to(:published)}
  it {should respond_to(:user_id)}

  #it {should not_be_published}
  it {should validate_presence_of :title}
  it {should validate_presence_of :price}
  it {should validate_presence_of :published}
  it {should validate_numericality_of(:price).is_greater_than_or_equal_to(0)}

  it {should belong_to :user}
  
end
