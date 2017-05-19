class Room < ApplicationRecord
  has_many :pcs

  has_and_belongs_to_many :operating_systems
end
