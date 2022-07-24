require 'swagger_helper'

describe 'Pokemons API' do
  path '/pokemons' do
    get 'Lists all pokemons' do
      tags 'Pokemons'
      produces 'application/json'

      response '200', 'Pokemons found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   types: {
                     type: :array,
                     items: { type: :string }
                   }
                 }
               }

        let!(:pokemons)  { create_list(:pokemon, 2) }
        run_test!
      end
    end
  end

  path '/pokemons/{id}' do
    get 'Retrieves a pokemon' do
      tags 'Pokemons'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Pokemons found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 base_experience: { type: :integer },
                 height: { type: :integer },
                 is_default: { type: :boolean },
                 name: { type: :string },
                 order: { type: :integer },
                 weight: { type: :integer },
                 poke_api_id: { type: :integer },
                 types: {
                   type: :array,
                   items: { type: :string }
                 }
               }

        let(:pokemon)  { create(:pokemon) }
        let(:id) { create(:pokemon).id }
        run_test!
      end

      response '404', 'Pokemons not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
