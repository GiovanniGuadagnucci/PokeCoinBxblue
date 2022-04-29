class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy
  serialize :pokemons, Hash

  def wallet_total_avaluation_balance(bitcoin_value)
    invested = invested_balance(bitcoin_value)
    avaluation = invested + balance
    percentage = (avaluation / 1000 - 1) * 100

    {
      current_value: avaluation,
      percentage:
    }
  end

  def wallet_avaluation_by_pokemon(wallet_pokemons, current_pokemon_value)
    avaluation = wallet_pokemons[:amount] * current_pokemon_value
    percentage = (avaluation / wallet_pokemons[:total_paid_price] - 1) * 100
    {
      current_value: avaluation,
      percentage:
    }
  end

  def invested_balance(bitcoin_value)
    sum = 0
    pokemons.each do |pokemon|
      sum += (pokemon.first.value_in_dollar(bitcoin_value) * pokemon.last[:amount])
    end
    sum
  end
end
