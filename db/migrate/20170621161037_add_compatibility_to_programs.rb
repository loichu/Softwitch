class AddCompatibilityToPrograms < ActiveRecord::Migration[5.1]
  def change
    add_column :programs, :compatibility, :string
  end
end
