class PokemonDataImporter
  def call
    import_pokemons
    import_types
  end

  private

  def import_pokemons
    PokeAPI.pokemons { |pokemon_hash| import_pokemon(pokemon_hash) }
  end

  def import_types
    PokeAPI.types { |type_hash| import_type(type_hash) }
  end

  def import_pokemon(pokemon_hash)
    # ignore pokemons we already imported
    return if Pokemon.exists?(poke_api_id: pokemon_hash['id'])

    Pokemon.create(
      poke_api_id: pokemon_hash['id'],
      name: pokemon_hash['name'],
      base_experience: pokemon_hash['base_experience'],
      height: pokemon_hash['height'],
      is_default: pokemon_hash['is_default'],
      order: pokemon_hash['order'],
      weight: pokemon_hash['weight'],
    )
  end

  def import_type(type_hash)
    # ignore types we already imported
    return if Type.exists?(poke_api_id: type_hash['id'])

    Type.create(
      poke_api_id: type_hash['id'],
      name: type_hash['name'],
    )
  end
end
