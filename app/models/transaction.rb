class Transaction < ApplicationRecord
  belongs_to :wallet
  serialize :pokemon
end
