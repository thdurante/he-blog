module Blog
  class UsersController < ApplicationController
    skip_before_action :authenticate_user!
    before_action :set_user, only: [:show]

    def show
      @post = Post.new
      @posts = Post.where(user_id: @user.id).paginate(page: params[:page], per_page: 4)
    end

    private

    def set_user
      @user = params[:id] ? User.find(params[:id]) : current_user
    end
  end
end
