class AddDefaultToDogs < ActiveRecord::Migration[5.1]
  def change
    change_column :dogs, :is_sterilized, :boolean, default: false, null: false
  end
end
