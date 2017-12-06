module Api
  class SessionsController < Api::ApiController
    skip_before_action :get_current_user, only: [:create]

    def create
      user = User.find_by(sbd: params[:sbd].downcase)

      unless user
        render json: {}, status: 404 and return
      end

      if user && user.authenticate(params[:password])
        session[:user_id] = user[:id]

        render json: user.detail_info
      else
        render json: {}, status: 401
      end
    end

    def destroy
      session[:user_id] = nil
      render json: {}
    end

    def me
      if @current_user
        render json: @current_user.detail_info
      else
        render json: {}, status: 401
      end
    end
  end
end
