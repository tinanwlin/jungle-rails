require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should be valid if user fills out all fields and passwords match" do
      @user = User.new(firstname: 'Bob', lastname: 'Su', email: 'bob@bob.com', password: '123', password_confirmation: '123')
      @user.save
      expect(@user.errors.full_messages).to be_empty
    end
  
    it "is not valid if password and password_confirmation is not match" do
      @user = User.new(firstname: 'Bob', lastname: 'Su', email: 'bob@bob.com', password: '123', password_confirmation: '1234')
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    
    it "is not valid if email is not unique and case sensitive" do
      @user1 = User.new(firstname: 'Bob', lastname: 'Su', email: 'bob@bob.com', password: '123', password_confirmation: '123')
      @user1.save
      @user2 = User.create(firstname: 'Sam', lastname: 'Bu', email: 'BOB@BOB.com', password: '123', password_confirmation: '123')
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it "is not valid without email" do
      @user = User.new(firstname: 'Bob', lastname: 'Su', email: nil, password: '123', password_confirmation: '123')
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "is not valid without firstname" do
      @user = User.new(firstname: nil, lastname: 'Su', email: 'bob@bob.com', password: '123', password_confirmation: '123')
      @user.save
      expect(@user.errors.full_messages).to include("Firstname can't be blank")
    end

    it "is not valid without lastname" do
      @user = User.new(firstname: 'Bob', lastname: nil, email: 'bob@bob.com', password: '123', password_confirmation: '123')
      @user.save
      expect(@user.errors.full_messages).to include("Lastname can't be blank")
    end

    it "is not valid when user create a account with length of password less than 3" do
      @user = User.new(firstname: 'Bob', lastname: 'Su', email: 'bob@bob.com', password: '12', password_confirmation: '12')
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    
    it 'authenticate a user with credentials' do
      @user = User.create(firstname: 'Bob', lastname: 'Su', email: 'bob@bob.com', password: '123', password_confirmation: '123')
      expect(User.authenticate_with_credentials('bob@bob.com', '123')).to eq @user
    end

    it 'authenticate a user with credentials using spaces in the email' do
      @user = User.create(firstname: 'Bob', lastname: 'Su', email: 'bob@bob.com', password: '123', password_confirmation: '123')
      expect(User.authenticate_with_credentials(' bob@bob.com', '123')).to eq @user
    end

    it 'authenticate a user with credentials using wrong case in the email' do
      @user = User.create(firstname: 'Bob', lastname: 'Su', email: 'bob@bob.com', password: '123', password_confirmation: '123')
      expect(User.authenticate_with_credentials('BOB@bob.com', '123')).to eq @user
    end
  end

end
