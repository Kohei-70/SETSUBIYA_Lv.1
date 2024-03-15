class Public::SearchesController < ApplicationController
  def index
  end

  def show
  end

  def search
    # @model = params[:model]
    # @quiztitle = params[:title]
    # @method = params[:method]

    @model = "quiz" # モデル指定をQuizのみに変更します
    @quiz_title = Quiz.find(params[:title])
    @method = params[:method]
    @results = Quiz.search_for(@quiz_title, @method) # Quizモデルの検索メソッドを呼び出します

    # 選択したモデルに応じて検索を実行
    # if @model  == "user"
    #   @records = User.search_for(@content, @method)
    # else
    #   @records = Books.search_for(@content, @method)
    # end

  end

end
