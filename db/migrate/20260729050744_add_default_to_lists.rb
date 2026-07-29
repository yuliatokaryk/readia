class AddDefaultToLists < ActiveRecord::Migration[8.1]
  def change
    add_column :lists, :default, :boolean, default: false, null: false
  end
end
