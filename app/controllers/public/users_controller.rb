class Public::UsersController < ApplicationController
  # 権限の設定
  before_action :authenticate_user!

  def show
    # 参考
    @user = User.find(params[:id])
    if Rails.env.development?
      @random_quiz = Quiz.order("RANDOM()").first
    else
      @random_quiz = Quiz.order("RAND()").first
    end

    @ranking = []

    User.where(user_status: 0).each do |user|
      answer_count = user.answer_records.joins(:quiz).where("answer_records.answer=quizzes.answer").count
      quiz_count = user.answer_records.count
      per = 0
      unless (quiz_count <= 0)
        par = ((answer_count.to_f / quiz_count.to_f).to_f * 100).round
      end
      # if par.nil?
        @ranking << [per, user.name, user.id]
      # end
    end

    @ranking.sort_by! {|x| x[0] }
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
