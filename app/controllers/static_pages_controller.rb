class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @users = User.paginate(page: params[:page], per_page: 6)
  end
end
