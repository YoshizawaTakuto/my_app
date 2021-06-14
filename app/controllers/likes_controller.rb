class LikesController < ApplicationController
    before_action :no_login
    
    def create
        @like = Like.new(
            user_id: @login_user.id,
            post_id: params[:id]
        )
        @like.save
        redirect_to post_path(params[:id])
    end

    def destroy
        @like = Like.find_by(
            user_id: @login_user.id,
            post_id: params[:id]
        )
        @like.destroy
        redirect_to post_path(params[:id])
    end
end