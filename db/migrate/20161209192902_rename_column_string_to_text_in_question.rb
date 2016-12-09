class RenameColumnStringToTextInQuestion < ActiveRecord::Migration
  def change
    rename_column(:questions, :string, :text)
  end
end
