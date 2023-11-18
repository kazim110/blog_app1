class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(user: current_user)
    

    if @like.save
      redirect_to user_post_path(@post.author, @post), notice: 'Like added successfully.'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Error adding like.'
    end
  end
end