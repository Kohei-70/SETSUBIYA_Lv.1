class Public::QuizzesController < ApplicationController
  # 権限の設定
  before_action :authenticate_user!

  def quiz
    # 問題をランダムな順番で取得
    if Rails.env.development?
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
      @result = 'correct.jpg'
    else
      @result = 'incorrect.jpg'
    end

    @quiz_comment = QuizComment.new

    # @quiz = Quiz.find(params[:id])
    # user_answer = params[:answer]

    # @answer_record = AnswerRecord.new(
    #   quiz_id: @quiz.id,
    #   user_id: current_user.id,
    #   answer: user_answer.to_i
    # )

    # if @answer_record.save
    #   flash[:success] = "回答が保存されました。"
    # else
    #   flash[:error] = "回答の保存に失敗しました。"
    # end

    # if @answer_record.answer == @quiz.answer
    #   @result = "正解です！"
    # else
    #   @result = "不正解です..."
    # end

    # @quiz_comment = QuizComment.new

  end

end
