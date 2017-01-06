class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :questioning_user, class_name: 'User'
  has_and_belongs_to_many :tags

  validates_presence_of :text, :user

  validates_length_of :text, maximum: 255

  before_save :create_h_tags

  def self.get_tags_from_question(question)
    question.text.scan(/#[\w]+/).map {|tag| tag.downcase.delete('#')}
  end

  def create_h_tags
    tags = Question.get_tags_from_question(self)
    h_tags = tags.map {|tag| Tag.find_or_create_by(title: tag)}

    self.tags = h_tags if h_tags.any?
  end
end
