class Question < ActiveRecord::Base

  belongs_to :user
  belongs_to :questioning_user, class_name: 'User'
  has_and_belongs_to_many :tag

  validates_presence_of :text, :user

  validates_length_of :text, maximum: 255

  before_save :create_h_tags

  def create_h_tags
    h_tags = []
    tags = Question.get_tags_from_question(self)
    tags.each do |tag|
      h_tags << Tag.find_or_create_by(title: tag)
    end

    self.tag = h_tags if h_tags.any?
  end


  def self.get_tags_from_question(question)
    tag_arr = []
    question.text.scan(/#[\w]+/).each do |tag|
      tag_arr << tag.downcase.delete('#')
    end
    tag_arr
  end
end
