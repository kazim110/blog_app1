class CommentsController < ApplicationController
  layout 'application'

  before_action :configure_permitted_parameters, if: :devise_controller?

  def new
    @user = User.includes(:posts).find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(post: @post)
  end

  def create
    @user = User.includes(:posts).find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.new(comment_params.merge(user: @user))

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_path(@user, @post), notice: 'Comment created' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
