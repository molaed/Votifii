class AddWinnerToElections < ActiveRecord::Migration[7.0]
  def change
    add_column :elections, :winner_id, :integer
  end
end
