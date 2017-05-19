class CreateSoftwares < ActiveRecord::Migration[5.1]
  def change
    create_table :softwares do |t|
      t.string :name

      t.timestamps
    end
  end
end
