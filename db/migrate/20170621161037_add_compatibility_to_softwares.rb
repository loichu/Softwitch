class AddCompatibilityToSoftwares < ActiveRecord::Migration[5.1]
  def change
    add_column :softwares, :compatibility, :string
  end
end
