class AddDetailsToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :age, :int
    add_column :people, :cheveux, :string
  end
end
