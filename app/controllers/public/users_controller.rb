class Public::UsersController < ApplicationController
  def show
    # 参考
    @user = User.find(params[:id])
    @quizzes = @user.quizzes
    @quiz = Quiz.new
    @today_quiz =  @quizzes.created_today
    @yesterday_quiz = @quizzes.created_yesterday
    @this_week_quiz = @quizzes.created_this_week
    @last_week_quiz = @quizzes.created_last_week
  end

  def edit
  end
end
