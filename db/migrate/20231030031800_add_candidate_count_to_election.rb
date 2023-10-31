class AddCandidateCountToElection < ActiveRecord::Migration[7.0]
  def change
    remove_column :elections, :candidateCount
  end
end
