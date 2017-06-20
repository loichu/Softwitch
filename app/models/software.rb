class Software < ApplicationRecord
  belongs_to :editor
  has_many :versions
end
