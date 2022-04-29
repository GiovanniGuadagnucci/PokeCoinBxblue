class Transaction < ApplicationRecord
  validates :operation, presence: true
  validates :value, presence: true
  validates :amount, presence: true
  validates :pokemon, presence: true

  belongs_to :wallet
  serialize :pokemon
end
