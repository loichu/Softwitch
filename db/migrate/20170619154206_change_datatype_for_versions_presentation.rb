class ChangeDatatypeForVersionsPresentation < ActiveRecord::Migration[5.1]
  def change
    change_column :versions, :presentation, :text
  end
end
