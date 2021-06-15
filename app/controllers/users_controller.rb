class UsersController < ApplicationController
  before_action :no_login, except: [:new, :create, :login, :login_form]
  before_action :set_login, only: [:new, :create, :login_form, :login]
  before_action :no_edit_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.all.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザーを登録しました"
      redirect_to posts_path
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を変更しました"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "ユーザー情報を削除しました"
    redirect_to posts_path
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to posts_path
    else
      @message = "メールアドレスかパスワードが間違っています"
      render "login_form"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_form_path
  end

  def likes
    @user = User.find(params[:id])
    @liked_post = Post.joins(:likes).where(likes: { user: @user })
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def no_edit_user
    @user = User.find(params[:id])
    if @login_user != @user
      flash[:notice] = "権限がありません"
      redirect_to posts_path
    end
  end
end
