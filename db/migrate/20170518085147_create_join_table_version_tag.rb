class CreateJoinTableVersionTag < ActiveRecord::Migration[5.1]
  def change
    create_join_table :versions, :tags do |t|
      # t.index [:version_id, :tag_id]
      # t.index [:tag_id, :version_id]
    end
  end
end
