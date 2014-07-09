class CreateAcceptableAnswers < ActiveRecord::Migration
  def change
    create_table :acceptable_answers do |t|
      t.integer :answer_choice_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :acceptable_answers, [:user_id, :answer_choice_id], unique: true
  end
end
