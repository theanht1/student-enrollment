module Api
  class UsersController < Api::ApiController

    def update
      if @current_user.update({
        scores: params[:user][:scores]
      })
        render json: @current_user.detail_info
      else
        render json: {}, status: 400
      end
    end
  end
end
