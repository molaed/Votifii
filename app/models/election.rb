class Election < ApplicationRecord
  include Visible
  belongs_to :user #Belongs to User now
  has_many :candidates, dependent: :destroy
  VALID_STATES = ['public', 'archived']

  attribute :winner_id, :integer, default: nil
  attribute :status, :string, default: 'public'

  def archive_election
    if self.status == 'public'
      update(status: 'archived')
      puts "ARCHIVED THIS ELECTION"
    end
  end

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :status, inclusion: { in: VALID_STATES }

  
end
