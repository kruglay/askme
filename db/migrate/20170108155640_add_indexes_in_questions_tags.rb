class AddIndexesInQuestionsTags < ActiveRecord::Migration
  def change
    add_index :questions_tags, :tag_id
    add_index :questions_tags, :question_id
    add_index :questions_tags, [:question_id, :tag_id], unique: true
  end
end
