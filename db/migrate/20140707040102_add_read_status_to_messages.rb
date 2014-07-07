class AddReadStatusToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :read_status, :integer, default: 0
    add_index :messages, :read_status
  end
end