class Public::HomesController < ApplicationController
  def top
    if Rails.env.development?
      @random_quiz = Quiz.order("RANDOM()").first
    else
      @random_quiz = Quiz.order("RAND()").first
    end
  end
end