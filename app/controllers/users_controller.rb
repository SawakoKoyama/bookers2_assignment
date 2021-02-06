class UsersController < ApplicationController

  def index
    @users = User.all
    @user = current_user
  end


  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     flash[:notice] = "Successfully updated."
     redirect_to user_path(current_user)
    else
     render :edit
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
    flash[:notice] = "User is successfully created"
    redirect_to user_path(current_user)
    else
    render :new
    end
  end

private

def user_params
  params.require(:user).permit(:name, :profile_image, :introduction)
end



end


