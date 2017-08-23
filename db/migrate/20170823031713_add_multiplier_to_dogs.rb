class AddMultiplierToDogs < ActiveRecord::Migration[5.1]
  def change
    add_column :dogs, :multiplier, :float
  end
end
