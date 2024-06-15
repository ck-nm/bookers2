class UsersController < ApplicationController
    before_action :is_matching_login_user, only: [:edit, :update]
    before_action :authenticate_user!, except: [:top, :about]
    before_action :configure_permitted_parameters, if: :devise_controller?

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
      @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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

private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image )
  end
   def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path
    end
   end

end