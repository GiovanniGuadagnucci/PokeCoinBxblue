Rails.application.routes.draw do
  resources :pokemons
  devise_for :users

  post 'buy_pokemon', to: 'transactions#buy_pokemon'
  post 'sell_pokemon', to: 'transactions#sell_pokemon'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root 'home#index'
end
