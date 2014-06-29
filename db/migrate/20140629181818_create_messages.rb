class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body, null: false
      t.integer :sender_id, null: false
      t.integer :recipient_id, null: false
      t.integer :message_thread_id, null: false

      t.timestamps
    end
    
    add_index :messages, :sender_id
    add_index :messages, :recipient_id
    add_index :messages, :message_thread_id
  end
end