module UsersHelper
  def get_questions(questions)
    "у вас #{questions.count} #{I18n.t 'question', count: questions.count}"
  end
end
