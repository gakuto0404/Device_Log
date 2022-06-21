class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :review_comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :profile_image

  validates :nick_name, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :encrypted_password, presence: true
  validates :email, presence: true

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nick_name = "ゲスト"
      user.last_name = "ゲスト"
      user.first_name = "ユーザー"
    end
  end

  # is_activeがtrueならfalseを返すようにしている
  def active_for_authentication?
    super && (is_active == true)
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no-user-image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
