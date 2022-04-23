class Book < ApplicationRecord
  belongs_to :user
  has_many :favorite_from_user_to_books, dependent: :destroy
  has_many :favorite_users, through: :favorite_from_user_to_books, source: :user

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
