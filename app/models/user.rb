class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum sex: { male: 0, woman: 1 }
  validates :name,
    length: { minimum: 1, maximum: 10 }
  validates :email, presence: true
  validates :is_active, inclusion: { in: [true, false] }
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :spendings
  has_many :comments, dependent: :destroy
  attachment :profile_image
  has_many :liked_posts, through: :likes, source: :post
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

end
