class AddVotersToElections < ActiveRecord::Migration[7.0]
  def change
    add_column :elections, :voters, :integer, array: true, default: []
  end
end