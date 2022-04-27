class HomeController < ApplicationController
  def index
    @pokemons = Pokemon.all
    @current_user = current_user
  end
end
