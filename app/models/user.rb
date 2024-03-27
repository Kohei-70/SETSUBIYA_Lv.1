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

  # カレントユーザーの全問の回答数をカウント
  def total_quiz_count
    self.answer_records.count
  end

  # カレントユーザーの全問の正答数をカウント
  def total_answer_count
    self.answer_records.joins(:quiz).where("answer_records.answer=quizzes.answer").count
  end

  # カレントユーザーの全問の正答率
  def total_answer_parcent
    # answer_count = self.answer_records.joins(:quiz).where("answer_records.answer=quizzes.answer").count
    # quiz_count = self.answer_records.count
    if total_quiz_count == 0
      par = 0
    else
      par = ((total_answer_count.to_f / total_quiz_count.to_f).to_f * 100).round
    end
    return par
  end

  def day_quiz_count(day)
    self.answer_records.where("answer_records.created_at >= ?", day.beginning_of_day).where("answer_records.created_at < ?", day.end_of_day).count
  end

  def day_answer_count(day)
    self.answer_records.where("answer_records.created_at >= ?", day.beginning_of_day).where("answer_records.created_at < ?", day.end_of_day).joins(:quiz).where("answer_records.answer=quizzes.answer").count
  end



  # カレントユーザーでの１日あたりの正答率
  # def day_answer_parcent(day)
  #   answer_count = self.answer_records.where("answer_records.created_at like '%#{day}%'").joins(:quiz).where("answer_records.answer=quizzes.answer").count
  #   quiz_count = self.answer_records.where("answer_records.created_at like '%#{day}%'").count
  #   if quiz_count == 0
  #     par = 0
  #   else
  #     par = ((answer_count.to_f / quiz_count.to_f).to_f * 100).round
  #   end
  #   return par;
  # end

  def day_answer_parcent(day)
    answer_count = self.answer_records.where("answer_records.created_at >= ?", day.beginning_of_day).where("answer_records.created_at < ?", day.end_of_day).joins(:quiz).where("answer_records.answer=quizzes.answer").count
    quiz_count = self.answer_records.where("answer_records.created_at >= ?", day.beginning_of_day).where("answer_records.created_at < ?", day.end_of_day).count
    if quiz_count == 0
      par = 0
    else
      par = ((answer_count.to_f / quiz_count.to_f) * 100).round
    end
    return par
  end

end