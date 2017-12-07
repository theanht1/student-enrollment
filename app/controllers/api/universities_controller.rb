module Api
  class UniversitiesController < Api::ApiController
    skip_before_action :get_current_user, only: [:index, :search_universities,
      :branches, :list_branches]

    def index
      unis = University.order(:rank, :name, :branch, combination: :asc)
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

    def search_universities
      unis = University.distinct.pluck(:code, :name).map
      params[:q].split(' ').each do |q|
        unis = unis.select do |uni|
          uni[0].match(/#{q}/i) || uni[1].match(/#{q}/i)
        end
      end

      render json: {
        universities: unis.first(10).map do |uni|
          {
            code: uni[0],
            name: uni[1]
          }
        end,
      }
    end

    def branches
      unis = University.where(code: params[:code]).all

      render json: unis
    end

    def list_branches
      render json: University.order(:branch).distinct.pluck(:branch)
    end

    def recommend
      unis = University.order(:rank, :name).where(combination: ['A00', 'A01', 'B00', 'C00', 'D01'])
      params[:q].split(' ').each do |q|
        query = "%#{q}%"
        unis = unis.where("branch ILIKE ?", query)
      end

      unis = unis.all.map do |uni|
        score = @current_user.score_in(uni.combination)
        uni.as_json.merge({
          'prob' => uni.accepted_probability(score)
        })
      end

      threshold = 0.05
      unis = unis.sort do |x, y|
        if x['prob'] < y['prob']
          if (x['code'] != y['code']) && (x['rank'] > y['rank'] && y['prob'] - x['prob'] <= threshold)
            -1
          else
            1
          end
        else
          if (x['code'] != y['code']) && (x['rank'] < y['rank'] && x['prob'] - y['prob'] <= threshold)
            1
          else
            -1
          end
        end
        # y['prob'] <=> x['prob']
      end

      render json: unis
    end
  end
end
