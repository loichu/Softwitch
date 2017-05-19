class CreateEditors < ActiveRecord::Migration[5.1]
  def change
    create_table :editors do |t|
      t.string :name
      t.string :website

      t.timestamps
    end
  end
end
