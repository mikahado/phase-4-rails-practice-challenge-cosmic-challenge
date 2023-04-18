class MissionSerializer < ActiveModel::Serializer
  attributes :id, :name, :scientist_id, :planet_id, :length_in_days

  has_one :scientist
  has_one :planet

end
