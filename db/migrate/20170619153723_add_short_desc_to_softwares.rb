class AddShortDescToPrograms < ActiveRecord::Migration[5.1]
  def change
    add_column :programs, :short_desc, :string
  end
end
