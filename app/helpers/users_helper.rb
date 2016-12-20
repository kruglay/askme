module UsersHelper
  def get_questions(questions)
    "#{questions.count} #{I18n.t 'question', count: questions.count}"
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
