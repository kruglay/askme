module UsersHelper
  def get_questions(questions)
    "#{questions.count} #{I18n.t 'question', count: questions.count}"
  end

  #возвращает список цветов для выбора
  def color_choices
    User.color_choices
  end
end
