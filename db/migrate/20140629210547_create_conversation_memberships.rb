class CreateConversationMemberships < ActiveRecord::Migration
  def change
    create_table :conversation_memberships do |t|
      t.integer :user_id, null: false
      t.integer :conversation_id, null: false
      
      t.timestamps
    end
    
    add_index :conversation_memberships, :user_id
    add_index :conversation_memberships, :conversation_id
  end
end
