class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]

  before_action :authorize_user, only: [:update, :destroy]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: "Вы уже залогинены" if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: "Вы уже залогинены" if current_user.present?
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: 'Вы успешно зарегистрированы!'
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    user_params_before_save = user_params
    user_params_before_save[:color] = "" unless color_choices.flatten.include?(user_params[:color])
    if @user.update(user_params_before_save)
      redirect_to user_path(@user), notice: "Данные успешно обновлены"
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build
  end

  def destroy
    redirect_to root_path, notice: "Ваш пользовтель удален(( Возвращайтесь, если передумаете"
  end

  private
  def load_user
    @user = User.find(params[:id])
  end

  def authorize_user
    reject_user unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url, :color)
  end
end
