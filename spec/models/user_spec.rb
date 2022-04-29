require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = FactoryBot.create(:user)
  end

  it 'should contain a encrypted id' do
    expect(@user.attributes).to include('id')
    expect(@user.id).to be_a(Integer)
  end

  it 'should contain a attritbute email' do
    expect(@user.attributes).to include('email')
    expect(@user.email).to be_a(String)
  end

  it 'should contain a encrypted password' do
    expect(@user.attributes).to include('encrypted_password')
    expect(@user.password).to be_a(String)
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end

  it 'is not valid without an email' do
    user2 = FactoryBot.build(:user, email: nil)
    expect(user2).to_not be_valid
  end

  it 'is not valid without a password' do
    user2 = FactoryBot.build(:user, password: nil)
    expect(user2).to_not be_valid
  end

  it 'has a unique email' do
    user2 = FactoryBot.build(:user, email: @user.email)
    expect(user2).to_not be_valid
  end
end
