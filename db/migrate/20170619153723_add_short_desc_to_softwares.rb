class AddShortDescToSoftwares < ActiveRecord::Migration[5.1]
  def change
    add_column :softwares, :short_desc, :string
  end
end
