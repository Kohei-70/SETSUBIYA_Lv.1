class Public::QuizzesController < ApplicationController

  def index
    @quiz = Quiz.find(params[:id])
    @quiz = {}
    @selected_answer = nil
    @dialog = false
    @result = {
      answer: nil,
      description: nil,
      next_quiz_id: nil
    }
  end

  def show
    # respond_to do |format|
    # format.html
    # format.js # js形式で送信された場合はこちらが適応され、js.erbを探す
  # end
  end

end
