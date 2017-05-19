class CreateVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :versions do |t|
      t.string :name
      t.date :date
      t.boolean :distrilog
      t.string :installLink
      t.string :website
      t.string :presentation

      t.timestamps
    end
  end
end
