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

        render json: user
      else
        render json: {}, status: 401
      end
    end

    def destroy
    end
  end
end
