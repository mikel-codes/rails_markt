class Product < ApplicationRecord
  belongs_to :user
  
  validates :title, :user_id, :price :presence => true
  validates :price, numericality: {greater_than_or_equal_to: 0}
end
