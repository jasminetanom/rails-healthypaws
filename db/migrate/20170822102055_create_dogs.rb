class CreateDogs < ActiveRecord::Migration[5.1]
  def change
    create_table :dogs do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :photo
      t.float :weight
      t.string :activity_level
      t.boolean :is_sterilized
      t.string :life_stage
      t.string :weight_goal
      t.integer :body_conditioning_score
      t.float :coefficient

      t.timestamps
    end
  end
end
