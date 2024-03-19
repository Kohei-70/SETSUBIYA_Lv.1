class Quiz < ApplicationRecord
  # 検索機能
  # def self.search_for(title, method)
  #   #byebug
  #   if method == 'perfect'
  #     Quiz.where(title: title)
  #   elsif method == 'forward'
  #     Quiz.where('title LIKE ?', title + '%')
  #   elsif method == 'backward'
  #     Quiz.where('title LIKE ?', '%' + title)
  #   else
  #     Quiz.where('title LIKE ?', '%' + title + '%')
  #   end
  # end
  
  def self.search_for(title, method, model)
    if model == "quiz"
      if method == 'perfect'
        Quiz.where(title: title)
      elsif method == 'forward'
        Quiz.where('title LIKE ?', title + '%')
      elsif method == 'backward'
        Quiz.where('title LIKE ?', '%' + title)
      else
        Quiz.where('title LIKE ?', '%' + title + '%')
      end
    elsif model == "tag"
      # Quiz.where('tag LIKE ?', '%' + title + '%')
      if method == 'perfect'
        Quiz.where(tag: title)
      elsif method == 'forward'
        Quiz.where('title LIKE ?', title + '%')
      elsif method == 'backward'
        Quiz.where('title LIKE ?', '%' + title)
      else
        Quiz.where('title LIKE ?', '%' + title + '%')
      end
    end
  end

  # ブックマーク機能
  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks
  has_many :quiz_comments, dependent: :destroy
  # has_many :bookmarks, foreign_key: "quiz_id", dependent: :destroy

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

end
