class Public::QuizzesController < ApplicationController
  # 権限の設定
  before_action :authenticate_user!

  def quiz
    # 本番環境用として追加
    if Rails.env.development?
      # 問題をランダムな順番で取得
      @random_quiz = Quiz.order("RANDOM()").first
    else
      @random_quiz = Quiz.order("RAND()").first
    end
  end

  def show
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
      @result = 'correct.svg'
    else
      @result = 'incorrect.svg'
    end

    @quiz_comment = QuizComment.new
  end

end
