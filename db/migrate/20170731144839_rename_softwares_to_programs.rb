class RenameSoftwaresToPrograms < ActiveRecord::Migration[5.1]
  def change
    rename_table :programs, :programs
  end
end