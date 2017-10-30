class CreateJoinTableRoomOperatingSystem < ActiveRecord::Migration[5.1]
  def change
    create_join_table :rooms, :operating_systems do |t|
      # t.index [:room_id, :operating_system_id]
      # t.index [:operating_system_id, :room_id]
    end
  end
end
