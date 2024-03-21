class Public::QuizzesController < ApplicationController

  def quiz
    @random_quiz = Quiz.order("RANDOM()").first
    # @random_problem = Problem.order("RANDOM()").first # 問題をランダムな順番で取得
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
      @result = "正解です！"
    else
      @result = "不正解です..."
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
