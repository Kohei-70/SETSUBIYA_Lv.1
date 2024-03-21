class Public::UsersController < ApplicationController
  def show
    # 参考
    @user = User.find(params[:id])
    # @quizzes = @user.quizzes
    # @quiz = Quiz.new
    # @today_quiz =  @quizzes.created_today
    # @yesterday_quiz = @quizzes.created_yesterday
    # @this_week_quiz = @quizzes.created_this_week
    # @last_week_quiz = @quizzes.created_last_week
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  def withdraw_check
  end
  
  def withdraw_update
    user = current_user
    user.update(user_status: :inactive)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
