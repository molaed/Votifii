class AddVotersToCandidate < ActiveRecord::Migration[7.0]
  def change
    add_column :candidates, :voters, :integer, array: true, default: []
  end
end
