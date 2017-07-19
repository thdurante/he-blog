class RelationshipsController < ApplicationController
  def create
    user = User.find(relationship_params[:relationship][:followed_id])
    current_user.follow(user)
    flash[:success] = t('application.messages.relationships.followed_successfully')
    redirect_to blog_user_path(user)
  end

  def destroy
    user = Relationship.find(relationship_params[:id]).followed
    current_user.unfollow(user)
    flash[:success] = t('application.messages.relationships.unfollowed_successfully')
    redirect_to blog_user_path(user)
  end

  private

  def relationship_params
    params.permit(:id, relationship: [:followed_id])
  end
end
