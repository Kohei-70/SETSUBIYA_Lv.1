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
  def total_answer_parcent
    answer_count = self.answer_records.joins(:quiz).where("answer_records.answer=quizzes.answer").count
    quiz_count= self.answer_records.count
    par = ((answer_count.to_f/quiz_count.to_f).to_f*100).round
  end
  def day_answer_parcent(day)
    answer_count = self.answer_records.where("answer_records.created_at like '%#{day}%'").joins(:quiz).where("answer_records.answer=quizzes.answer").count
    quiz_count= self.answer_records.where("answer_records.created_at like '%#{day}%'").count
    if quiz_count == 0
      par = 0
    else
      par = ((answer_count.to_f/quiz_count.to_f).to_f*100).round
    end
    return par;
  end

  # def answer_count
  #   answer_records.count
  # end

  # def correct_answers_count
  #   answer_records.correct.count
  # end

end