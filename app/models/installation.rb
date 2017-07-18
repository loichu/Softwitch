class Installation < ApplicationRecord
  belongs_to :pc
  belongs_to :version
end
