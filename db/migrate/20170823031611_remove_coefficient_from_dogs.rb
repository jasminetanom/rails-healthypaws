class RemoveCoefficientFromDogs < ActiveRecord::Migration[5.1]
  def change
    remove_column :dogs, :coefficient, :float
  end
end
