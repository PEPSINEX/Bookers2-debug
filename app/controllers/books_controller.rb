class BooksController < ApplicationController

  def show
    @book = Book.includes(:user,:favorite_users).find(params[:id])
    @user = current_user
    @new_book = Book.new
  end

  def index
    @books = Book.includes(:favorite_users)
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user

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

    @book.user = current_user

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
    params.require(:book).permit(:title, :body)
  end
end
