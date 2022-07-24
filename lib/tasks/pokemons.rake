namespace :pokemons do
  desc 'Imports pokemons and types, updates existing ones if needed'
  task import: :environment do
    PokemonDataImporter.call
  end
end
