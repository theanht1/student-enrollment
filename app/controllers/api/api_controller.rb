module Api
  class ApiControler < ActionController::Base
    protect_from_forgery with: :exception,
                         unless: Proc.new{ (Rails.env.development? || Rails.env.test? || Rails.env.production?) }


end
