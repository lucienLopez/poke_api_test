# == Schema Information
#
# Table name: pokemons
#
#  id              :bigint           not null, primary key
#  base_experience :integer
#  height          :integer
#  is_default      :boolean
#  name            :string
#  order           :integer
#  weight          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  poke_api_id     :integer
#
# Indexes
#
#  index_pokemons_on_poke_api_id  (poke_api_id) UNIQUE
#
FactoryBot.define do
  factory :pokemon do
    sequence(:name) { |i| "pokemon #{i}" }
    sequence(:poke_api_id) { |i| i }
  end
end
