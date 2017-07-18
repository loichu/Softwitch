class Pc < ApplicationRecord
  has_one :room
  belongs_to :secret

  has_many :versions, through: :installations
  #has_and_belongs_to_many :versions
end
