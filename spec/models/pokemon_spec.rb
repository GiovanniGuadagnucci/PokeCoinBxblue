require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  before(:all) do
    @pokemon = FactoryBot.create(:pokemon)
  end

  it 'should contain a id' do
    expect(@pokemon.attributes).to include('id')
    expect(@pokemon.id).to be_a(Integer)
  end

  it 'should contain a attritbute name' do
    expect(@pokemon.attributes).to include('name')
    expect(@pokemon.name).to be_a(String)
  end

  it 'should contain a encrypted base_experience' do
    expect(@pokemon.attributes).to include('base_experience')
    expect(@pokemon.base_experience).to be_a(Integer)
  end

  it 'should contain a encrypted sprite' do
    expect(@pokemon.attributes).to include('sprite')
    expect(@pokemon.sprite).to be_a(String)
  end

  it 'shount be valid with valid attributes' do
    expect(@pokemon).to be_valid
  end

  it 'should not be valid without a name' do
    pokemon2 = FactoryBot.build(:pokemon, name: nil)
    expect(pokemon2).to_not be_valid
  end

  it 'should not be valid without a base_experience' do
    pokemon2 = FactoryBot.build(:pokemon, base_experience: nil)
    expect(pokemon2).to_not be_valid
  end

  it 'should not be valid without a sprite' do
    pokemon2 = FactoryBot.build(:pokemon, sprite: nil)
    expect(pokemon2).to_not be_valid
  end

  it 'should have a value_in_bitcoin' do
    expect(@pokemon.value_in_bitcoin).to eq(@pokemon.base_experience * 0.00000001)
  end

  it 'should have a value_in_dollar' do
    bitcoin_value = 10_000
    expect(@pokemon.value_in_dollar(bitcoin_value)).to eq(0.01)
  end
end
