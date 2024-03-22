class AnswerRecord < ApplicationRecord
  
  belongs_to :quiz
  belongs_to :user
  
  # def self.correct_count(user_id)
  #   where(user_id: user_id, answer: quiz.answer).count
  # end
  
  # def self.correct_count(user_id)
  #   where(user_id: user_id, is_correct: true).count
  # end
  
  # scope :correct, -> { where(is_correct: true) }
  
end
