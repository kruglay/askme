class Question < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :text, :user

  validates_length_of :text, maximum: 255
end
