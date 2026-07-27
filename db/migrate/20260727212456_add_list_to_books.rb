class AddListToBooks < ActiveRecord::Migration[8.1]
  def change
    add_reference :books, :list, null: true, foreign_key: true
  end
end
