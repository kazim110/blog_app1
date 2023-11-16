class UsersController < ApplicationController
  
  layout 'application'

  def index
    @users = User.all
  end

  def show; end
  
end
