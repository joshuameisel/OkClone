class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :gender, null: false
      t.boolean :likes_m, default: false
      t.boolean :likes_f, default: false
      t.integer :min_age, null: false
      t.integer :max_age, null: false
      t.date :dob, null: false
      t.string :country, null: false
      t.string :session_token, null: false
      t.integer :zip_code     
      t.string :email, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
    
    add_index :users, :session_token, :unique => true
    add_index :users, :username, :unique => true
  end
end
