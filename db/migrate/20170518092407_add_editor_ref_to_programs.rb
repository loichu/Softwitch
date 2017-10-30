class AddEditorRefToPrograms < ActiveRecord::Migration[5.1]
  def change
    add_reference :programs, :editor, foreign_key: true
  end
end
