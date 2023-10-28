class Election < ApplicationRecord
  has_many :candidates

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
end
