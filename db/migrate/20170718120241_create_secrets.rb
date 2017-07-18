class CreateSecrets < ActiveRecord::Migration[5.1]
  def change
    create_table :secrets do |t|
      t.string :url
      t.string :message
      t.string :password

      t.timestamps
    end
  end
end
