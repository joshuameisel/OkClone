class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :orientation, null: false
      t.date :birthdate, null: false
      t.string :country, null: false
      t.integer :zip_code     
      t.string :email, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
    
    add_index :users, :username
  end
end
