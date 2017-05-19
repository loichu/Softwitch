class Version < ApplicationRecord
  belongs_to :software

  has_and_belongs_to_many :tags
  has_and_belongs_to_many :operating_systems
  has_and_belongs_to_many  :pcs
end
