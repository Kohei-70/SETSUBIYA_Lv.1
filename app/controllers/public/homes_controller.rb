class Public::HomesController < ApplicationController
  def top
    @random_quiz = Quiz.order("RANDOM()").first
  end
end
