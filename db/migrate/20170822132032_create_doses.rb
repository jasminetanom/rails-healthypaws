class CreateDoses < ActiveRecord::Migration[5.1]
  def change
    create_table :doses do |t|
      t.references :recipe, foreign_key: true
      t.references :ingredient, foreign_key: true
      t.float :amount
      t.string :unit

      t.timestamps
    end
  end
end
