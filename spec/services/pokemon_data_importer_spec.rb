require 'rails_helper'

RSpec.describe PokemonDataImporter do
  let!(:fighting_type) { create(:type, poke_api_id: 2) }
  let!(:ivysaur_pokemon) { create(:pokemon, poke_api_id: 2, types: [fighting_type]) }

  it 'correctly imports pokemons and types' do
    allow(PokeAPI).to receive(:pokemons).and_yield(
      {
        'id' => 1,
        'base_experience' => 64,
        'height' => 7,
        'is_default' => true,
        'name' => 'bulbasaur',
        'order' => 1,
        'weight' => 69,
        'types' => [
          {
            'slot' => 1,
            'type' => {
              'name' => 'normal',
              'url' => 'fake.url'
            }
          },
          {
            'slot' => 2,
            'type' => {
              'name' => 'fighting',
              'url' => 'fake.url'
            }
          }
        ]
      }
    ).and_yield(
      {
        'id' => 2,
        'base_experience' => 142,
        'height' => 10,
        'is_default' => true,
        'name' => 'ivysaur',
        'order' => 2,
        'weight' => 130,
        'types' => [
          {
            'slot' => 1,
            'type' => {
              'name' => 'normal',
              'url' => 'fake.url'
            }
          }
        ]
      }
    )

    allow(PokeAPI).to receive(:types).and_yield(
      {
        'id' => 1,
        'name' => 'normal'
      }
    ).and_yield(
      {
        'id' => 2,
        'name' => 'fighting'
      }
    )

    described_class.call

    expect(Type.count).to eq(2)

    normal_type = Type.find_by(poke_api_id: 1)
    expect(normal_type.name).to eq('normal')

    fighting_type.reload
    expect(fighting_type.name).to eq('fighting')

    expect(Pokemon.count).to eq(2)

    bulbasaur_pokemon = Pokemon.find_by(poke_api_id: 1)
    expect(bulbasaur_pokemon).to(
      have_attributes(
        base_experience: 64, height: 7, is_default: true, name: 'bulbasaur', order: 1, weight: 69
      )
    )
    expect(bulbasaur_pokemon.types).to contain_exactly(fighting_type, normal_type)

    ivysaur_pokemon.reload
    expect(ivysaur_pokemon).to(
      have_attributes(
        base_experience: 142, height: 10, is_default: true, name: 'ivysaur', order: 2, weight: 130
      )
    )
    expect(ivysaur_pokemon.types).to contain_exactly(normal_type)
  end
end
