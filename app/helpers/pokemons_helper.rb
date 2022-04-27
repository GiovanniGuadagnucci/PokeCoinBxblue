module PokemonsHelper
  def pokemon_basexp_to_btc(basexp)
    format('%.10f', (basexp * 0.00000001))
  end
end
