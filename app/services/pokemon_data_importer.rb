class PokemonDataImporter
  def self.call
    import_pokemons
    import_types
  end

  private

  def self.import_pokemons
    PokeAPI.pokemons { |pokemon_hash| import_pokemon(pokemon_hash) }
  end

  def self.import_types
    PokeAPI.types { |type_hash| import_type(type_hash) }
  end

  def self.import_pokemon(pokemon_hash)
    Pokemon.find_or_initialize_by(poke_api_id: pokemon_hash['id'])
           .update(
             name: pokemon_hash['name'],
             base_experience: pokemon_hash['base_experience'],
             height: pokemon_hash['height'],
             is_default: pokemon_hash['is_default'],
             order: pokemon_hash['order'],
             weight: pokemon_hash['weight']
           )
  end

  def self.import_type(type_hash)
    Type.find_or_initialize_by(poke_api_id: type_hash['id']).update(name: type_hash['name'])
  end
end
