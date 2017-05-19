class CreateJoinTableVersionOperatingSystem < ActiveRecord::Migration[5.1]
  def change
    create_join_table :versions, :operating_systems do |t|
      # t.index [:version_id, :operating_system_id]
      # t.index [:operating_system_id, :version_id]
    end
  end
end
