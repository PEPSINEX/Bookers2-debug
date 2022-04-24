class BookCommentsController < ApplicationController
  def create
    comment = BookComment.new(book_comment_params)
    book = Book.find(params[:book_id])
    comment.book = book
    comment.save

    @comments = book.book_comments
  end

  def destroy
    book = Book.find(params[:book_id])
    comment = BookComment.find(params[:id])
    comment.destroy

    @comments = book.book_comments
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment).merge(user: current_user)
  end
end
