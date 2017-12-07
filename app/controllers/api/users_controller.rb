module Api
  class UsersController < Api::ApiController

    def update
      if @current_user.update({
        scores: params[:user][:scores],
        priority_score: params[:user][:priority_score]
      })
        render json: @current_user.detail_info
      else
        render json: {}, status: 400
      end
    end
  end
end
