class CreateInstallations < ActiveRecord::Migration[5.1]
  def change
    create_table :installations do |t|
      t.belongs_to :pc, index: true
      t.belongs_to :version, index: true
      t.boolean :installed

      t.timestamps
    end
  end
end
