class Review < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  belongs_to :genre
  has_many :review_comments, dependent: :destroy

end