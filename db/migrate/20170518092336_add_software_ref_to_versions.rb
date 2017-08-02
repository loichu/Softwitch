class AddProgramRefToVersions < ActiveRecord::Migration[5.1]
  def change
    add_reference :versions, :program, foreign_key: true
  end
end
