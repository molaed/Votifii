class Candidate < ApplicationRecord
  belongs_to :election
  after_initialize :default_values

private
  def default_values
    self.voteCount ||= 0
  end
end
