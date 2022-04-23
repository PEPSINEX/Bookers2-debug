class FavoriteFromUserToBooksController < ApplicationController
  def create
    user = current_user
    book = Book.find(params[:book])

    favorite = FavoriteFromUserToBook.new(user: user, book: book)
    favorite.save
    redirect_back(fallback_location: books_path)
  end

  def destroy
    favorite = FavoriteFromUserToBook.find(params[:id])
    favorite.destroy
    redirect_back(fallback_location: books_path)
  end
end
