# == Schema Information
#
# Table name: types
#
#  id          :bigint           not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  poke_api_id :integer
#
# Indexes
#
#  index_types_on_poke_api_id  (poke_api_id) UNIQUE
#
class Type < ApplicationRecord
  has_and_belongs_to_many :pokemons
end
