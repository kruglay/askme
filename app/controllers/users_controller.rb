class UsersController < ApplicationController
  def index
    @users = [
        User.new(
            id: 1,
            name: 'Vadim',
            username: 'installero',
            avatar_url: 'https://secure.gravatar.com/avatar/71269686e0f757ddb4f73614f43ae445?s=100'
        ),
        User.new(
            id: 2,
            name: 'Misha',
            username: 'aristofun'
        )
    ]
  end

  def new
  end

  def edit

  end

  def show
    @user = User.new(name: "Vladimir", username: "kruglay",
                     email: "a@am.ru", password: "123",
                     avatar_url: "http://1avatara.ru/pic/fantasy/fentasy025.jpg")
    @questions = [
        Question.new(text: 'Как дела?', created_at: Date.parse('13.12.2016')),
        Question.new(text: 'Как дела2?', created_at: Date.parse('13.12.2016'))
    ]

    @new_question = Question.new
  end
end