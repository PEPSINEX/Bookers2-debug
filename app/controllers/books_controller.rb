class BooksController < ApplicationController

  def show
    @book = Book.includes(:user, :favorite_users, :favorite_from_user_to_books).find(params[:id])
    @new_book = Book.new
    @book_comment = BookComment.new
    @book_comments = BookComment.where(book_id: params[:id])
  end

  def index
    if params[:created_desc]
      @books = Book.includes(:favorite_users, :favorite_from_user_to_books, :book_rating).created_desc
    elsif params[:rating_desc]
      @books = Book.includes(:favorite_users, :favorite_from_user_to_books, :book_rating).rating_desc
    elsif params[:category]
      @books = Book.joins(:book_tag).category(params[:category])
    else
      @books = Book.includes(:favorite_users, :favorite_from_user_to_books, :book_rating)
    end
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])

    unless @book.user == current_user
      flash[:notice] = '権限がありません'
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])

    unless @book.user == current_user
      flash[:notice] = '権限がありません'
      redirect_to books_path
    end

    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, book_rating_attributes: [:rate], book_tag_attributes: [:name]).merge(user: current_user)
  end
end
