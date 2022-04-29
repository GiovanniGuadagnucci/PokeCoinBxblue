class Pokemon < ApplicationRecord
  def value_in_bitcoin
    base_experience * 0.00000001
  end

  def value_in_dollar(bitcoin_value)
    value_in_bitcoin * bitcoin_value
  end
end
