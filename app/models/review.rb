class Review < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  belongs_to :genre
  has_many :review_comments, dependent: :destroy

  validates :image, presence: true
  validates :title, presence: true, length: { minimum: 2, maximum: 40 }
  validates :item_name, presence: true, length: { minimum: 2, maximum: 40 }
  validates :manufacture_name, presence: true, length: { minimum: 2, maximum: 40 }
  validates :impressions, presence: true, length: { minimum: 2, maximum: 400 }
  validates :purchase_price, presence: true
  validates :purchase_source, presence: true, length: { minimum: 2, maximum: 20 }

  scope :search, -> (search_params) do
    return if search_params.blank?

    item_name_like(search_params[:item_name])
      .genre_id_is(search_params[:genre_ids])
  end
  scope :item_name_like, -> (item_name) { where('item_name LIKE ?', "%#{item_name}%") if item_name.present? }
  scope :genre_id_is, -> (genre_id) { where(genre_id: genre_id) if genre_id.present? }
end