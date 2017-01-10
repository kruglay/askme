# == Schema Information
#
# Table name: questions
#
#  id                  :integer          not null, primary key
#  name                :string
#  answer              :string
#  text                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :integer
#  questioning_user_id :integer
#
# Indexes
#
#  index_questions_on_user_id  (user_id)
#

class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :questioning_user, class_name: 'User'
  has_and_belongs_to_many :tags

  validates_presence_of :text, :user

  validates_length_of :text, maximum: 255

  before_save :create_h_tags

  def self.get_tags_from_question(question)
    question.text.scan(/#[\w]+/).map {|tag| tag.downcase.delete('#')}.uniq
  end

  def create_h_tags
    Question.get_tags_from_question(self).map {|tag| Tag.find_or_create_by(title: tag)}
  end
end
