class PostsController < ApplicationController
  before_action :set_post, only: [:destroy]

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = t('application.messages.posts.successfully_created')
      redirect_to blog_user_path(current_user)
    else
      flash[:error] = @post.errors.full_messages
      redirect_to blog_user_path(current_user)
    end
  end

  def destroy
    @post.destroy
    flash[:success] = t('application.messages.posts.successfully_deleted')
    redirect_to blog_user_path(current_user)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :user_id, :_destroy)
  end
end
