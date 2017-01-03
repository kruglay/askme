class TagsController < ApplicationController
  def show
    @hashtag = Tag.find(params[:id])
    @questions = @hashtag.question
  end
end
