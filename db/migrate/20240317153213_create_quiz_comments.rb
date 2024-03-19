class CreateQuizComments < ActiveRecord::Migration[6.1]
  def change
    create_table :quiz_comments do |t|
      t.integer :user_id
      t.integer :quiz_id
      t.text    :comment
      t.timestamps
    end
  end
end
