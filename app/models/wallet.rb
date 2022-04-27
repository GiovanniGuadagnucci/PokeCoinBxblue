class Wallet < ApplicationRecord
  belongs_to :user, dependent: :destroy
  serialize :pokemons
end
