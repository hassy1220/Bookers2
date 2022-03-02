class BooksController < ApplicationController
  before_action :authenticate_user!
    before_action :correct_books,only: [:edit]
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end
  
  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:create]="You have created book successfully."
        redirect_to book_path(@book)
    else
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
  
  # urlにて直接/editと入力しても他人のコードを編集できないようにするもの
  def correct_books
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
    redirect_to books_path
    end
  end
  
  private
  
  def books_params
    params.require(:book).permit(:title,:body)
  end
end
