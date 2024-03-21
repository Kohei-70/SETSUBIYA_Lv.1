class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #has_many :quizzes
  has_many :bookmarks, dependent: :destroy
  #has_many :bookmarked_quizzes, through: :bookmarks, source: :quiz
  has_many :quizzes, through: :bookmarks
  has_many :quiz_comments, dependent: :destroy
  has_many :answer_records

  enum user_status: { active: 0, banned: 1, inactive: 2 }
  
  # ログインしたユーザーがactiveかどうか
  def active_for_authentication?
    super && (user_status == 'active')
  end
  
  # def answer_count
  #   answer_records.count
  # end
  
  # def correct_answers_count
  #   answer_records.correct.count
  # end

end