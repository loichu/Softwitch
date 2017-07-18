class AddIpAddressToPcs < ActiveRecord::Migration[5.1]
  def change
    add_column :pcs, :IP, :inet
  end
end
