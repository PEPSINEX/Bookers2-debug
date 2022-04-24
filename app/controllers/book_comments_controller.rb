class BookCommentsController < ApplicationController
  def create
    comment = BookComment.new(book_comment_params)
    book = Book.find(params[:book_id])

    comment.book = book

    if comment.save
      redirect_to book_path(book), notice: "You have created book_comment successfully."
    else
      redirect_to book_path(book), notice: "失敗時のメッセージ"
    end
  end

  def destroy
    book = Book.find(params[:book_id])
    comment = BookComment.find(params[:id])

    if comment.destroy
      redirect_to book_path(book), notice: "You have destroyed book_comment successfully."
    else
      redirect_to book_path(book), notice: "失敗時のメッセージ"
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment).merge(user: current_user)
  end
end
