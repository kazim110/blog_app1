class PostsController < ApplicationController

  layout 'aplication'

  def index
    @posts = Post.all
  end

  def show; end
end
