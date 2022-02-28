class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     flash[:create]="You have created book successfully."
     redirect_to book_path(@book)
    else
      # @book = Book.new
      @books = Book.all
      @user = current_user
      render:index
    end
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(books_params)
      flash[:update]="You have updated book successfully."
      redirect_to book_path(@book)
    else
      render:edit
    end
  end
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    # userコントローラのshowより新規投稿する際、require(:book)が邪魔になるから除去した
    params.permit(:title,:body)
  end
  def books_params
    params.require(:book).permit(:title,:body)
  end
end
