module Api
  class UniversitiesController < Api::ApiController
    skip_before_action :get_current_user, only: [:search]

    def search
      unis = University
      params[:q].split(' ').each do |q|
        query = "%#{q}%"
        unis = unis.where("name ILIKE ? OR branch ILIKE ?", query, query)
      end
      render json: unis.first(10)
    end
  end
end
