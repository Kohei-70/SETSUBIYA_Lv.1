class QuizComment < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  
  validates :comment, presence: true
  
end
