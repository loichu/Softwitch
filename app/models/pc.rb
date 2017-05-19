class Pc < ApplicationRecord
  has_one :room

  has_and_belongs_to_many :versions
end
