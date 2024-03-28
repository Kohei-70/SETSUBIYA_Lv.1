class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :bookmarks, dependent: :destroy
  has_many :quizzes, through: :bookmarks
  has_many :quiz_comments, dependent: :destroy
  has_many :answer_records

  enum user_status: { active: 0, banned: 1, inactive: 2 }

  # ログインしたユーザーがactiveかどうか
  def active_for_authentication?
    super && (user_status == 'active')
  end

  # １日あたりのカレントユーザーの回答数をカウント
  def day_quiz_count(day)
    self.answer_records.where("answer_records.created_at >= ?", day.beginning_of_day).where("answer_records.created_at < ?", day.end_of_day).count
  end

  # １日あたりのカレントユーザーの正答数をカウント
  def day_answer_count(day)
    self.answer_records.where("answer_records.created_at >= ?", day.beginning_of_day).where("answer_records.created_at < ?", day.end_of_day).joins(:quiz).where("answer_records.answer=quizzes.answer").count
  end

end

# # 余裕があれば導入したい機能
# # トータル回答数の表示
# # これまでのカレントユーザーの回答数をカウント
# def total_quiz_count
#   self.answer_records.count
# end

# # これまでのカレントユーザーの正答数をカウント
# def total_answer_count
#   self.answer_records.joins(:quiz).where("answer_records.answer=quizzes.answer").count
# end

# # 正答率の表示
# # これまでのカレントユーザーの正答率
# def total_answer_parcent
#   if total_quiz_count == 0
#     par = 0
#   else
#     par = ((total_answer_count.to_f / total_quiz_count.to_f).to_f * 100).round
#   end
#   return par
# end


# # １日あたりのカレントユーザーの正答率
# def day_answer_parcent(day)
#   if quiz_count == 0
#     par = 0
#   else
#     par = ((day_answer_count.to_f / day_quiz_count.to_f) * 100).round
#   end
#   return par
# end