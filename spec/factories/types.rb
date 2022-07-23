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
FactoryBot.define do
  factory :type do
    sequence(:name) { |i| "type #{i}" }
    sequence(:poke_api_id) { |i| i }
  end
end
