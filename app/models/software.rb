class Software < ApplicationRecord
  belongs_to :editor
  #accepts_nested_attributes_for :editor

  has_many :versions
end
