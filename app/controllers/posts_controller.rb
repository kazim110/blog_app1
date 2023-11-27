class PostsController < ApplicationController
  layout 'application'

  before_action :authenticate_user!

  def index
    @user = current_user
    @posts = Post.includes(:comments, :likes, comments: [:user])
  end

  def show
    @post = Post.includes(:comments, likes: [:user], comments: [:user]).find(params[:id])
    @user = current_user
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_posts_path(@user), notice: 'Post was successfully created.' }
      else
        flash.now[:error] = 'Failed to create the post.'
        Rails.logger.debug @post.errors.inspect
        render :new
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
