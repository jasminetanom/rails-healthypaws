class ChangeDogsUsersIndex < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :dogs, :users

    add_foreign_key :dogs, :users, on_delete: :cascade
  end
end
