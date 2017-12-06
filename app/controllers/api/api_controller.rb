module Api
  class ApiController < ActionController::Base
    protect_from_forgery with: :exception,
                         unless: Proc.new{ (Rails.env.development? || Rails.env.test? || Rails.env.production?) }

    before_action :get_current_user

    private
      def get_current_user
        @current_user = User.find(session[:user_id]) if !session[:user_id].blank?
      end
  end
end
