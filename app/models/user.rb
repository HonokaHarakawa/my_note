class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum sex: { male: 0, woman: 1 }
  has_many :incomes
  validates :name, presence: true
  has_many :posts, dependent: :destroy
  has_many :spendings
  attachment :profile_image
end
