class PostsController < ApplicationController
  before_action :no_login
  before_action :no_edit_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create 
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "新規投稿しました"
      redirect_to "/"
    else
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
    @likes_count = Like.where(post_id: params[:id]).count
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to post_path(@post)
    else
      render "posts/edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to "/"
  end

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end

  def no_edit_post
    @post = Post.find(params[:id])
    if @login_user.id != @post.user_id
      flash[:notice] = "権限がありません"
      redirect_to "/"
    end
  end

end
