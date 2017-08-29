class LendingController < ApplicationController
  skip_authorization_check
  
  def index
    # Inner Join between two models
    @posts = Post.joins(:user)
  end
end
