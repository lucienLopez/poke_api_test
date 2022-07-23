class CreatePokemonsAndTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.integer :poke_api_id
      t.string :name
      t.integer :base_experience
      t.integer :height
      t.boolean :is_default
      t.integer :order
      t.integer :weight

      t.index :poke_api_id, unique: true

      t.timestamps
    end

    create_table :types do |t|
      t.integer :poke_api_id
      t.string :name

      t.index :poke_api_id, unique: true

      t.timestamps
    end

    create_join_table :pokemons, :types, column_options: { foreign_key: true }
  end
end
