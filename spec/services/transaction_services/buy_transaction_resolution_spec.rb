require 'rails_helper'

RSpec.describe TransactionServices::BuyTransactionResolution, type: :model do
  before(:all) do
    @current_user = FactoryBot.create(:user)
    @pokemon = FactoryBot.create(:pokemon)
    @amount = 1
    @value = 0.01
    @wallet = @current_user.wallet
  end

  it 'should respond to #call' do
    expect(TransactionServices::BuyTransactionResolution.new(@pokemon.id, @amount, @value,
                                                             @wallet)).to respond_to(:call)
  end

  it 'should contain only one public instance method named #call' do
    expect(TransactionServices::BuyTransactionResolution.instance_methods(false)).to eq([:call])
  end

  it 'should create a new transaction' do
    TransactionServices::BuyTransactionResolution.call(@pokemon.id, @amount, @value, @wallet)
    expect(@wallet.transactions.count).to eq(1)
  end

  it 'should decrease the balance of the wallet' do
    expect do
      TransactionServices::BuyTransactionResolution.call(@pokemon.id, @amount, @value, @wallet)
    end.to change { @wallet.balance }.by(-@value * @amount)
    expect(@wallet.balance).to eq(0.99998e3)
  end

  it "should create a new pokemon in the wallet's pokemons hash if pokemon is not present" do
    pokemon2 = FactoryBot.create(:pokemon)
    expect(@wallet.pokemons.key?(pokemon2)).to eq(false)
    TransactionServices::BuyTransactionResolution.call(pokemon2.id, @amount, @value, @wallet)
    expect(@wallet.pokemons.key?(pokemon2)).to eq(true)
  end

  it 'should increase the amount of the pokemon in the wallet' do
    pokemon3 = FactoryBot.create(:pokemon)
    TransactionServices::BuyTransactionResolution.call(pokemon3.id, @amount, @value, @wallet)
    expect(@wallet.pokemons[pokemon3][:amount]).to eq(1)
  end

  it 'should increase the amount of pokemon in the wallet if pokemon is already in the wallet' do
    pokemon4 = FactoryBot.create(:pokemon)
    TransactionServices::BuyTransactionResolution.call(pokemon4.id, @amount, @value, @wallet)
    TransactionServices::BuyTransactionResolution.call(pokemon4.id, @amount, @value, @wallet)
    expect(@wallet.pokemons[pokemon4][:amount]).to eq(2)
  end

  it 'should increase the total paid price of the pokemon in the wallet' do
    pokemon5 = FactoryBot.create(:pokemon)
    TransactionServices::BuyTransactionResolution.call(pokemon5.id, @amount, @value, @wallet)
    expect(@wallet.pokemons[pokemon5][:total_paid_price].reduce(:+)).to eq(@value)
  end

  it 'should increase the total paid price of the pokemon in the wallet if pokemon is already in the wallet' do
    pokemon6 = FactoryBot.create(:pokemon)
    TransactionServices::BuyTransactionResolution.call(pokemon6.id, @amount, @value, @wallet)
    TransactionServices::BuyTransactionResolution.call(pokemon6.id, @amount, @value, @wallet)
    expect(@wallet.pokemons[pokemon6][:total_paid_price].reduce(:+)).to eq(@value * 2)
  end

  it 'should add a new item to total paid price' do
    pokemon7 = FactoryBot.create(:pokemon)
    TransactionServices::BuyTransactionResolution.call(pokemon7.id, @amount, @value, @wallet)
    TransactionServices::BuyTransactionResolution.call(pokemon7.id, @amount, @value, @wallet)
    expect(@wallet.pokemons[pokemon7][:total_paid_price].count).to eq(2)
  end
end
