class ReviewComment < ApplicationRecord
  belongs_to :review
  belongs_to :user

  validates :comment, presence: true, length: { minimum: 2, maximum: 300 }
end
