module Blog
  class UsersController < ApplicationController
    require 'will_paginate/array'

    skip_before_action :authenticate_user!
    before_action :set_user, only: [:show]

    def show
      @post = Post.new
      @posts = Post.where(user_id: @user.id).paginate(page: params[:post_page], per_page: 4)
      fetch_recent_activity
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def fetch_recent_activity
      @recent_activity = []
      @user.following.each do |user|
        @recent_activity << user.posts
      end
      @recent_activity = @recent_activity.flatten.sort! { |a,b| b[:created_at] <=> a[:created_at] }
      @recent_activity = @recent_activity.paginate(page: params[:recent_activity_page], per_page: 4)
    end
  end
end
