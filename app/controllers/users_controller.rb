class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_logged_in, only: [:edit, :update, :destroy]
  before_action :require_account_owner, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @articles = @user.articles
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "User created successfully."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account information was updated successfully."
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_account_owner
    if current_user != @user
      flash[:warning] = "You are not allowed to perform this action"
      redirect_to user_path
    end
  end
end