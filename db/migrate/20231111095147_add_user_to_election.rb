class AddUserToElection < ActiveRecord::Migration[7.0]
  def change
    add_reference :elections, :user, null: false, foreign_key: true
  end
end
