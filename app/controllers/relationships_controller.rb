class RelationshipsController < ApplicationController
  def create
    follower = current_user
    followed = User.find(params[:user_id])

    relationship = Relationship.new(follower: follower, followed: followed)

    if relationship.save
      redirect_back fallback_location: users_path, notice: "You followed user successfully."
    else
      redirect_back fallback_location: users_path, notice: "失敗時のメッセージ"
    end
  end

  def destroy
    relationship = Relationship.find(params[:id])

    if relationship.destroy
      redirect_back fallback_location: users_path, notice: "You followed user successfully."
    else
      redirect_back fallback_location: users_path, notice: "失敗時のメッセージ"
    end
  end
end
