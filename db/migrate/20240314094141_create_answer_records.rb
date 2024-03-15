class CreateAnswerRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :answer_records do |t|
      t.integer :quizzes_id, null: false
      t.integer :user_id,    null: false
      t.integer :answer

      t.timestamps
    end
  end
end
