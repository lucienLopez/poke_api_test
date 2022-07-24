json.array! @pokemons do |pokemon|
  json.id pokemon.id
  json.name pokemon.name
  json.types pokemon.type_names
end
