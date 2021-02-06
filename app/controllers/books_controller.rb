class BooksController < ApplicationController
  before_action :ensure_correct_user, :only => [:edit, :update]
  
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end


  def create
    @book = Book.new(book_params)
    user = current_user
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book is successfully created."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "Book is successfully updated."
    redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def new
    @book = Book.new
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def ensure_correct_user
    @post = Book.find_by(id:params[:id])
    if @post.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end


