class Public::SearchesController < ApplicationController
  def index
  end

  def show
  end

  def search
    # @model = "Quiz"
    # @quiz_title = params[:title]
    # @method = params[:method]
    # @quizzes = Quiz.search_for(@quiz_title, @method).page(params[:page])
    
    @model = params[:model]
    @quiz_title = params[:title]
    @method = params[:method]
    @quizzes = Quiz.search_for(@quiz_title, @method, @model).page(params[:page])
  end

end
