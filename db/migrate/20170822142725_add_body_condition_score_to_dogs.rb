class AddBodyConditionScoreToDogs < ActiveRecord::Migration[5.1]
  def change
    add_column :dogs, :body_condition_score, :integer
  end
end
