class UsersController < ApplicationController
 def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    # @bookfind = Book.find(params[:id])
 end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
        render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def create
    @book = Book.new(book_params)
    # @book.user_id = current_user.id
    @book.save
    redirect_to books_path
  end

  def search
    @users = User.search(params[:keyword])
    @book = Book.search(params[:keyword])
  end



  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end