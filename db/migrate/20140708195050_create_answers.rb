class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :answer_choice_id
      t.integer :user_id
    end

    add_index :answers, [:user_id, :answer_choice_id]
  end
end
