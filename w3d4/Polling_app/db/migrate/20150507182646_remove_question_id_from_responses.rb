class RemoveQuestionIdFromResponses < ActiveRecord::Migration
  def up
    remove_column :responses, :question_id
  end

  def down
    add_column :responses, :question_id, null: false
  end
end
