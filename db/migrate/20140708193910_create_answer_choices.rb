class CreateAnswerChoices < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.text :body, null: false
      t.integer :question_id, null: false
      t.integer :order, null: false

      t.timestamps
    end

    add_index :answer_choices, :question_id
    add_index :answer_choices, [:question_id, :order], unique: true
  end
end