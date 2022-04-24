class FavoriteFromUserToBooksController < ApplicationController
  def create
    user = current_user
    @book = Book.find(params[:book])

    favorite = FavoriteFromUserToBook.new(user: user, book: @book)
    favorite.save
  end

  def destroy
    favorite = FavoriteFromUserToBook.find(params[:id])
    @book = favorite.book
    favorite.destroy
  end
end
