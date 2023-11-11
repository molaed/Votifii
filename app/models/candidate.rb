class Candidate < ApplicationRecord
  belongs_to :election, optional: true
  after_initialize :default_values

  has_one_attached: :profile_image # profile_images are attached to the candidate object

private
  def default_values
    self.voteCount ||= 0
  end
end
