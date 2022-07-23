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
      },
    )

    allow(PokeAPI).to receive(:types).and_yield(
      {
        'id' => 1,
        'name' => 'normal',
      }
    ).and_yield(
      {
        'id' => 2,
        'name' => 'fighting',
      },
    )

    PokemonDataImporter.call

    expect(Pokemon.count).to eq(2)

    bulbasaur_pokemon = Pokemon.find_by(poke_api_id: 1)
    expect(bulbasaur_pokemon.base_experience).to eq(64)
    expect(bulbasaur_pokemon.height).to eq(7)
    expect(bulbasaur_pokemon.is_default).to be(true)
    expect(bulbasaur_pokemon.name).to eq('bulbasaur')
    expect(bulbasaur_pokemon.order).to eq(1)
    expect(bulbasaur_pokemon.weight).to eq(69)

    ivysaur_pokemon.reload
    expect(ivysaur_pokemon.base_experience).to eq(142)
    expect(ivysaur_pokemon.height).to eq(10)
    expect(ivysaur_pokemon.is_default).to be(true)
    expect(ivysaur_pokemon.name).to eq('ivysaur')
    expect(ivysaur_pokemon.order).to eq(2)
    expect(ivysaur_pokemon.weight).to eq(130)

    expect(Type.count).to eq(2)

    normal_type = Type.find_by(poke_api_id: 1)
    expect(normal_type.name).to eq('normal')

    fighting_type.reload
    expect(fighting_type.name).to eq('fighting')
  end
end
