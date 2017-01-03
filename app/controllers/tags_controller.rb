class TagsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @hashtag = Tag.find(params[:id])
    @questions = @hashtag.question
    render 'index'
  end
end
