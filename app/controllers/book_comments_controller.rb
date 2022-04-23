class BookCommentsController < ApplicationController
  def create
    comment = BookComment.new(book_comment_params)
    book = Book.find(params[:book_id])

    comment.user = current_user
    comment.book = book

    if comment.save
      redirect_to book_path(book), notice: "You have created book_comment successfully."
    else
      redirect_to book_path(book), notice: "失敗時のメッセージ"
    end
  end

  def destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
