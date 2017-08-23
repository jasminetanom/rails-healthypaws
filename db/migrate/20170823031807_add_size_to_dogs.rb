class AddSizeToDogs < ActiveRecord::Migration[5.1]
  def change
    add_column :dogs, :size, :string
  end
end
