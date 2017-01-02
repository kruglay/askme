class TagsController < ApplicationController
  def index
    @questions = Tag.all
  end

  def show
    @hashtag = Tag.find(params[:id])
    @questions = @hashtag.question
    render 'index'
  end
end
