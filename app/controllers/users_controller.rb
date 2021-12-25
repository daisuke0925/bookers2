class UsersController < ApplicationController

  before_action :authenticate_user!

  before_action :ensure_current_user, {only: [:edit,:update,:destroy]}


  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.where(user_id: @user.id)
  end

  def new
    @user = User.new(user_params)
    if @user.save
      redirect_to  user_path(current_user.id)
    else
      render "users/sign_up"
    end
  end


  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
       redirect_to user_path(@user.id)
    else
      flash[:notice] = " errors prohibited this obj from being saved:"
       render :edit
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def user_params
        params.require(:user).permit(:name,:profile_image,:introduction)
  end

   def ensure_current_user
        @user = User.find(params[:id])
     if @user.id != current_user.id
        redirect_to user_path(current_user.id)
     end
   end

end