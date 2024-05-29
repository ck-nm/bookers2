class UsersController < ApplicationController
  def create
       @user = User.new(user_params)
     if @user.save
       redirect_to user_path(@user.id)
     else
       render :users
     end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end
  # 一覧ページ用のアクション
  def index
    @users = User.all
    @user = current_user
  end

  def edit
  end
  def update
   if @user.update(user_params)
     redirect_to user_path(@user.id)
   else
     render :edit
   end
  end
  def destroy
    @user.destroy
    redirect_to root_path
  end

end
