class BooksController < ApplicationController

 before_action :authenticate_user!
 before_action :ensure_current_user, {only: [:edit,:update,:destroy]}

  def new
     @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
     if @book.save
    flash[:notice] = "You have creatad book successfully."
     redirect_to book_path(@book.id)
     else
    @books = Book.all
    @user = current_user
     render :index
     end
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
     redirect_to "/books"
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
    flash[:notice] = "You have creatad book successfully."
     redirect_to  book_path(@book.id)
    else
    @books = Book.all
    flash[:notice]= ' errors prohibited this obj from being saved:'
     render "edit"
    end
  end


 private
   def book_params
      params.require(:book).permit(:title, :body)
   end

   def user_params
      params.require(:user).permit(:name,:profile_image,:introduction)
   end

   def ensure_current_user
      @book = Book.find(params[:id])
     if @book.user_id != current_user.id
        redirect_to books_path
     end
   end
end
