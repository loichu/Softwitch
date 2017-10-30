class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :building
      t.string :number

      t.timestamps
    end
  end
end
