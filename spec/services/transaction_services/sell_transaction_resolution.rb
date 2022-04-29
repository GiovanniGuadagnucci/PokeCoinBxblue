require 'rails_helper'

RSpec.describe TransactionServices::SellTransactionResolution, type: :model do
  before(:all) do
    @current_user = FactoryBot.create(:user)
    @pokemon = FactoryBot.create(:pokemon)
    @amount = 1
    @value = 0.01
    @wallet = @current_user.wallet
    # adding a pokemon to the wallet to resolve the sell transaction test
  end

  it 'should respond to #call' do
    expect(TransactionServices::SellTransactionResolution.new(@pokemon.id, @amount, @value,
                                                              @wallet)).to respond_to(:call)
  end

  it 'should contain only one public instance method named #call' do
    expect(TransactionServices::SellTransactionResolution.instance_methods(false)).to eq([:call])
  end

  it 'should create a new transaction' do
    TransactionServices::BuyTransactionResolution.call(@pokemon.id, @amount, @value, @wallet)
    expect(@wallet.transactions.count).to eq(1)
    TransactionServices::SellTransactionResolution.call(@pokemon.id, @amount, @value, @wallet)
    expect(@wallet.transactions.count).to eq(2)
  end

  it 'should increase the balance of the wallet' do
    TransactionServices::BuyTransactionResolution.call(@pokemon.id, @amount, @value, @wallet)
    expect do
      TransactionServices::SellTransactionResolution.call(@pokemon.id, @amount, @value, @wallet)
    end.to change { @wallet.balance }.by(@value * @amount)
    expect(@wallet.balance).to eq(1000)
  end

  it "should delete pokemon from the wallet's pokemons hash if the amount is == 0" do
    TransactionServices::BuyTransactionResolution.call(@pokemon.id, @amount, @value, @wallet)
    TransactionServices::SellTransactionResolution.call(@pokemon.id, @amount, @value, @wallet)
    expect(@wallet.pokemons.key?(@pokemon)).to eq(false)
  end

  it 'should decrease the amount of the pokemon in the wallet' do
    TransactionServices::BuyTransactionResolution.call(@pokemon.id, @amount, @value, @wallet)
    TransactionServices::BuyTransactionResolution.call(@pokemon.id, @amount, @value, @wallet)
    expect do
      TransactionServices::SellTransactionResolution.call(@pokemon.id, @amount, @value, @wallet)
    end.to change { @wallet.pokemons[@pokemon][:amount] }.by(-@amount)
    expect(@wallet.pokemons[@pokemon][:amount]).to eq(1)
  end

  it 'should delete a item from total paid price list' do
    pokemon2 = FactoryBot.create(:pokemon)
    TransactionServices::BuyTransactionResolution.call(pokemon2.id, @amount, @value, @wallet)
    TransactionServices::BuyTransactionResolution.call(pokemon2.id, @amount, @value, @wallet)
    TransactionServices::SellTransactionResolution.call(pokemon2.id, @amount, @value, @wallet)
    expect(@wallet.pokemons[pokemon2][:total_paid_price].count).to eq(1)
  end
end
