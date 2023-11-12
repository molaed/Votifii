class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :election
  belongs_to :candidate
end