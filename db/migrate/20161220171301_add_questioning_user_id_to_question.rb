class AddQuestioningUserIdToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :questioning_user_id, :integer
  end
end
