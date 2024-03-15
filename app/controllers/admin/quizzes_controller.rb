class Admin::QuizzesController < ApplicationController

  def index
    @quizzes = Quiz.page(params[:page]).per(10)
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      redirect_to admin_quiz_path(@quiz)
    else
      render :new
    end
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def edit
    @quiz = Quiz.find(params[:id])
  end

  def update
    @quiz = Quiz.find(params[:id])
    if @quiz.update(quiz_params)
      redirect_to admin_quiz_path(@quiz)
    else
      render :edit
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:tag, :title, :question, :answer1, :answer2, :answer3, :answer4, :answer, :description)
  end
end
