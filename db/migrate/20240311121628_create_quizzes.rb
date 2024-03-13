class CreateQuizzes < ActiveRecord::Migration[6.1]
  def change
    create_table :quizzes do |t|
      t.string :tag,       null: false
      t.string :title,     null: false
      t.string :question
      t.string :answer1
      t.string :answer2
      t.string :answer3
      t.string :answer4
      t.integer :answer
      t.text :description
      t.timestamps
    end
  end
end
