class Election < ApplicationRecord
  include Visible
  has_many :candidates, dependent: :destroy
  VALID_STATES = ['public', 'archived']

  def archive_election
    if self.status == 'public'
      update(status: 'archived')
    end
    puts "ARCHIVED THIS ELECTION"
  end

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :status, inclusion: { in: VALID_STATES }
end
