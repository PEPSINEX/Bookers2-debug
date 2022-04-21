class FavoriteFromUserToBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, uniqueness: { scope: :book_id }
  validates :user, presence: true
  validates :book, presence: true
end