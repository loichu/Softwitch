class AddMacAddressToPcs < ActiveRecord::Migration[5.1]
  def change
    add_column :pcs, :MAC, :macaddr
  end
end
