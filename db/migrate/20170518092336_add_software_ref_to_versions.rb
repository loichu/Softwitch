class AddSoftwareRefToVersions < ActiveRecord::Migration[5.1]
  def change
    add_reference :versions, :software, foreign_key: true
  end
end
