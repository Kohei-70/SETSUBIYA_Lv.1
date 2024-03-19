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
  
end
