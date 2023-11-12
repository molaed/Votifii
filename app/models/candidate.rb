class Candidate < ApplicationRecord
  belongs_to :election, optional: true
  after_initialize :default_values

  # has_one_attached :profile_image

  # validates :speech, presence: true

private
  def default_values
    self.voteCount ||= 0
  end
end
