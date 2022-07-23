class PokemonsController < ApplicationController
  before_action :find_pokemon, only: :show

  def show
    render formats: [:json]
  end

  def index
    @pokemons = Pokemon.all
    render formats: [:json]
  end

  private

  def find_pokemon
    @pokemon = Pokemon.find_by(id: params[:id])
    head :not_found if @pokemon.blank?
  end
end
