require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it "should not be valid when password and password confirmation don't match" do
      a_user = User.new(name: "Srinath", password: "1234", password_confirmation: "5678")
      expect(a_user).to_not be_valid
    end

    it "should not be valid when password and password confirmation don't exist" do
      a_user = User.new(name: "Srinath")
      expect(a_user).to_not be_valid
    end

    it "should not be valid when email is not unique" do
      a_user = User.new(
        name: "John",
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      )
      b_user = User.new(
        name: "John_clever",
        email: "TEST@TEST.COM",
        password: "1234",
        password_confirmation: "5678"
      )
      expect(b_user).to_not be_valid
      expect(b_user.save).to be false
    end

    it "should not be valid when name and email is missing" do
      a_user = User.new(password: "1234", password_confirmation: "1234")
      expect(a_user).to_not be_valid
    end

    it "should not be valid when password is too short" do
      a_user = User.new(name: "Srinath", password: "12", password_confirmation: "5678")
      expect(a_user).to_not be_valid
      expect(a_user.save).to be false
    end

  end

  describe '.authenticate_with_credentials' do

    it 'should return nil if user enters wrong email' do
      user = User.create(
        name: 'ABC',
        email: 'random@123.com',
        password: '1234',
        password_confirmation: '1234'
      )
      test_user = User.authenticate_with_credentials('123@random.com', user.password)
      expect(test_user).to be_nil
    end

    it 'should return nil if user enters wrong password' do
      user = User.create(
        name: 'ABC',
        email: 'abc@abc.com',
        password: '1234',
        password_confirmation: '1234'
      )
      test_user = User.authenticate_with_credentials('abc@abc.com', '5678')
      expect(test_user).to be_nil
    end

    it 'should return a user if visitor uses extra spaces & random case' do
      user = User.create(
        name: 'ABC',
        email: 'abc@abc.com',
        password: '1234',
        password_confirmation: '1234'
      )
      test_user = User.authenticate_with_credentials('  abC@aBc.Com ', '1234')
      expect(test_user).to be_a User
    end

  end
end
