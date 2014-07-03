class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      t.text :summary
      t.text :job
      t.text :fortes
      t.text :physical_forte
      t.text :likes
      t.text :six_things
      t.text :think_about
      t.text :friday_night
      t.text :most_private
      t.integer :religion
      t.integer :ethnicity
      t.string :height

      t.timestamps
    end
    
    add_index :profiles, :user_id, :unique => true
  end
end