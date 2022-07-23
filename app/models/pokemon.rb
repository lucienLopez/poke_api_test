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
class Pokemon < ApplicationRecord
  has_and_belongs_to_many :types

  validates :poke_api_id, uniqueness: true, presence: true
end
