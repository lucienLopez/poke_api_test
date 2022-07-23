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
    puts "pokemon_hash: #{pokemon_hash['name']}"
    # TODO
  end

  def import_type(type_hash)
    puts "type_hash: #{type_hash['name']}"
    # TODO
  end
end
