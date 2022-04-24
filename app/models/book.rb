class Book < ApplicationRecord
  belongs_to :user
  has_many :favorite_from_user_to_books, dependent: :destroy
  has_many :favorite_users, through: :favorite_from_user_to_books, source: :user
  has_many :book_comments, dependent: :destroy
  has_one :book_rating, dependent: :destroy
  accepts_nested_attributes_for :book_rating
  has_one :book_tag, dependent: :destroy
  accepts_nested_attributes_for :book_tag

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  scope :search, -> (method, word) {
    case method
    when 'exact'
      where(['title LIKE(?) OR body LIKE(?)', word, word])
    when 'forward'
      where(['title LIKE(?) OR body LIKE(?)', "#{word}%", "#{word}%"])
    when 'backward'
      where(['title LIKE(?) OR body LIKE(?)', "%#{word}", "%#{word}"])
    when 'partial'
      where(['title LIKE(?) OR body LIKE(?)', "%#{word}%", "%#{word}%"])
    end
  }

  scope :created_desc, -> { order(created_at: :desc) }
  scope :rating_desc, -> { order('book_ratings.rate DESC') }
end
