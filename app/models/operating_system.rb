class OperatingSystem < ApplicationRecord
  has_and_belongs_to_many :versions
  has_and_belongs_to_many :rooms
end
