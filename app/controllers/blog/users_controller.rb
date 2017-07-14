module Blog
  class UsersController < ApplicationController
    skip_before_action :authenticate_user!
    before_action :set_user, only: [:show]

    def show
    end

    private

    def set_user
      @user = params[:id] ? User.find(params[:id]) : current_user
    end
  end
end
