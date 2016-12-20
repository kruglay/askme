class Question < ActiveRecord::Base

  belongs_to :user
  belongs_to :questioning_user, class_name: 'User'

  validates_presence_of :text, :user

  validates_length_of :text, maximum: 255
end
