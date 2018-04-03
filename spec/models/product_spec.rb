require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should be created if user fills out all fields in the form" do
      @category = Category.new(name: 'Shoes')
      @product = Product.new(name: 'React', price: 100, quantity: 10, category: @category)
      @product.save
      expect(@product.errors.full_messages).to be_empty
    end
   
    it "is not valid without a product name" do
      @category = Category.new(name: 'Shoes')
      @product = Product.new(name: nil, price: 100, quantity: 10, category: @category)
      @product.valid?
      expect(@product.errors[:name]).to include("can't be blank")
    end
    
    it "is not valid without a product price" do
      @category = Category.new(name: 'Shoes')
      @product = Product.new(name: 'React', price: nil, quantity: 10, category: @category)
      @product.valid?
      expect(@product.errors[:price]).to include("can't be blank")
    end

    it "is not valid without a product quantity" do
      @category = Category.new(name: 'Shoes')
      @product = Product.new(name: 'React', price: 100, quantity: nil, category: @category)
      @product.valid?
      expect(@product.errors[:quantity]).to include("can't be blank")
    end 

    it "is not valid without a product quantity" do
      @category = Category.new(name: 'Shoes')
      @product = Product.new(name: 'React', price: 100, quantity: 10, category: nil)
      @product.valid?
      expect(@product.errors[:category]).to include("can't be blank")
    end 

  end 
end
