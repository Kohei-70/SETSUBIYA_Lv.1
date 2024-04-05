class Public::QuizCommentsController < ApplicationController
  def create
    @quiz = Quiz.find(params[:quiz_id])
    @comment = current_user.quiz_comments.new(quiz_comment_params)
    @comment.quiz_id = @quiz.id
    @comment.score = Language.get_data(quiz_comment_params[:comment])  #この行を追加
    if @comment.score >= -0.7
      @comment.save
    end
  end

  def destroy
    @comment = QuizComment.find(params[:id])
    @comment.destroy
  end

  private

  def quiz_comment_params
    params.require(:quiz_comment).permit(:comment)
  end
end
