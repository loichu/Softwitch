class AddInventoryNumberToPcs < ActiveRecord::Migration[5.1]
  def change
    add_column :pcs, :inventory_number, :string
  end
end
