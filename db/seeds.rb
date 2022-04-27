# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

pokemon_list = PokeApi.get(pokemon: { limit: 151, offset: 0 }).results
pokemon_list.each do |pokemon|
  fetched_poke = PokeApi.get(pokemon: pokemon.name)
  Pokemon.create(name: fetched_poke.name, base_experience: fetched_poke.base_experience,
                 sprite: fetched_poke.sprites.front_default)
end
