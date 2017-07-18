class AddPcRefToSecrets < ActiveRecord::Migration[5.1]
  def change
    add_reference :secrets, :pc, foreign_key: true
  end
end
