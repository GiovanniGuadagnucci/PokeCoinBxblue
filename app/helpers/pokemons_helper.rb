module PokemonsHelper
  def pokemon_basexp_to_btc(basexp)
    format('%.10f', (basexp * 0.00000001))
  end

  def pokemon_btc_value_to_usd(btc_value, basexp)
    format('%.10f', (btc_value * (basexp * 0.00000001)))
  end
end
