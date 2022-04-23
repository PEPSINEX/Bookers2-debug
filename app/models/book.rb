class Book < ApplicationRecord
  belongs_to :user
  has_many :favorite_from_user_to_books, dependent: :destroy
  has_many :favorite_users, through: :favorite_from_user_to_books, source: :user
  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  scope :search, -> (method, word) {
    case method
    when :exact
      where(['title LIKE(?) OR body LIKE(?)', word, word])
    when :forward
      where(['title LIKE(?) OR body LIKE(?)', "#{word}%", "#{word}%"])
    when :backward
      where(['title LIKE(?) OR body LIKE(?)', "%#{word}", "%#{word}"])
    when :partial
      where(['title LIKE(?) OR body LIKE(?)', "%#{word}%", "%#{word}%"])
    end
  }
end
