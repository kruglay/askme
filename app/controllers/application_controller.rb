class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :color_choices

  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def reject_user
    redirect_to root_path, alert: "Вам сюда нельзя!"
  end

  #возвращает список цветов для выбора
  def color_choices
    [
        ['Серый','slategray', {style: 'color: slategray'}, {class: "form-select-option"}],
        ['Голубой','blue', {style: 'color: blue'}, {class: "form-select-option"}],
        ['Бирюзовый','turquoise', {style: 'color: turquoise'}, {class: "form-select-option"}],
        ['Ораньжевый','orange', {style: 'color: orange'}, {class: "form-select-option"}],
        ['Зеленый','green', {style: 'color: green'}, {class: "form-select-option"}]
    ]
  end
end
