class CreateJoinTableVersionPc < ActiveRecord::Migration[5.1]
  def change
    create_join_table :versions, :pcs do |t|
      # t.index [:version_id, :pc_id]
      # t.index [:pc_id, :version_id]
    end
  end
end
