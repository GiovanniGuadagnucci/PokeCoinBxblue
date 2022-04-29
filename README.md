# PokeCoin Bxblue

this project simulates a portfolio of investments based on pokemons in NFT model

You can buy and sell first generation pokemons (the one that really matters), track the profit and loss of your investments and see the history of your transactions.

The pokemon data was created from PokeApi in version 2 (https://pokeapi.co/).

The value of Pokemon in bitcoins is equivalent to 0.00000001 BTC per experience point.

the entire project was created and developed in Ruby on Rails 7 and deployed on Heroku (https://bx-blue-pokecoin.herokuapp.com/)

## TODO's for improvement

- migrate the database to mongodb when rails 7 becomes compatible, in order to increase the flexibility of the app

- create an api version for third-party consumption, preferably in graphql (because this technology is amazing)

- change the front end to a more interesting framework like react or vue, or at least implement hotwire and turbolink

- implement new features such as: buy more than one pokemon at a time, graphical presentation of the wallet's history, more detailed transactions.
