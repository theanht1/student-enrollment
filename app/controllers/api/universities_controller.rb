module Api
  class UniversitiesController < Api::ApiController
    skip_before_action :get_current_user, only: [:index]

    def index
      unis = University.order(:rank)
      params[:q].split(' ').each do |q|
        query = "%#{q}%"
        unis = unis.where("code ILIKE ? OR name ILIKE ? OR branch ILIKE ?", query, query, query)
      end

      offset = ((params[:page] || '1').to_i - 1) * params[:per].to_i
      render json: {
        universities: unis.offset(offset).first(params[:per]),
        total: unis.count
      }
    end
  end
end
