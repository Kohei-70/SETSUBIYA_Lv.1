class Public::SearchesController < ApplicationController
  def index
  end

  def search
    @model = params[:model]
    @quiz_title = params[:title]
    @method = params[:method]
    @quizzes = Quiz.search_for(@quiz_title, @method, @model).page(params[:page])
  end
  
  def quiz
    @search_quiz = Quiz.find(params[:id])
    @model = params[:model]
    @quiz_title = params[:title]
    @method = params[:method]
  end

  def answer
    @quiz = Quiz.find(params[:id])
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
    
    @model = params[:model]
    @quiz_title = params[:title]
    @method = params[:method]
    # @quizzes = Quiz.search_for(@quiz.title, @method, @model).page(params[:page])
    
  end

end
