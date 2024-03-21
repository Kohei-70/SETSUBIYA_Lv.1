class Public::BookmarksController < ApplicationController
  def index
    #bookmarks = Bookmark.where(user_id: current_user.id).pluck(:quiz_id)
    # @bookmark_quizzes = Quiz.find(bookmarks)
    @bookmark_quizzes = current_user.quizzes.page(params[:page])
  end

  def show
  end

  def quiz
    @bookmark_quiz = Quiz.find(params[:quiz_id])
  end

  def answer
    @quiz = Quiz.find(params[:quiz_id])
    user_answer = params[:answer]
    @answer_record = AnswerRecord.new
    @answer_record.quiz_id = @quiz.id
    @answer_record.user_id = current_user.id
    @answer_record.answer = user_answer.to_i
    @answer_record.save
    if @answer_record.answer == @quiz.answer
      @result = "正解です！"
    else
      @result = "不正解です..."
    end
    @quiz_comment = QuizComment.new
  end

  def create
    quiz = Quiz.find(params[:quiz_id])
    @bookmark = current_user.bookmarks.new(quiz_id: quiz.id)
    @bookmark.save
    render 'replace_btn'
  end

  def destroy
    quiz = Quiz.find(params[:quiz_id])
    @bookmark = current_user.bookmarks.find_by(quiz_id: quiz.id)
    @bookmark.destroy
    render 'replace_btn'
  end

end
