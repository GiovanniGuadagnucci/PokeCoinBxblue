class Pokemon < ApplicationRecord
  validates :name, presence: true
  validates :base_experience, presence: true
  validates :sprite, presence: true


  def value_in_bitcoin
    base_experience * 0.00000001
  end

  def value_in_dollar(bitcoin_value)
    value_in_bitcoin * bitcoin_value
  end
end
