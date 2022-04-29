require 'rails_helper'

RSpec.describe TransactionServices::CheckSellTransaction, type: :model do
  before(:all) do
    @current_user = FactoryBot.create(:user)
    @pokemon = FactoryBot.create(:pokemon)
    @amount = 1
    @value = 0.01
    @wallet = @current_user.wallet
  end

  it 'should respond to #call' do
    expect(TransactionServices::CheckSellTransaction.new(@pokemon.id, @value, @wallet)).to respond_to(:call)
  end

  it 'should contain only one public instance method named #call' do
    expect(TransactionServices::CheckSellTransaction.instance_methods(false)).to eq([:call])
  end

  it 'should return a value of type Boolean' do
    expect(TransactionServices::CheckSellTransaction.call(@pokemon.id, @value, @wallet)).to be_in([true, false])
  end

  it 'should return true if the transaction can be made' do
    TransactionServices::BuyTransactionResolution.call(@pokemon.id, @amount, @value, @wallet)
    expect(TransactionServices::CheckSellTransaction.call(@pokemon.id, @value, @wallet)).to eq(true)
  end

  it 'should return false if the transaction can not be made' do
    pokemon = FactoryBot.create(:pokemon)
    expect(TransactionServices::CheckSellTransaction.call(pokemon.id, @value, @wallet)).to eq(false)
  end
end
