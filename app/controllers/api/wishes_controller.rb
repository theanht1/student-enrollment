module Api
  class WishesController < Api::ApiController
    def index
      render json: @current_user.wishes.includes(:universities).map do |wish|
        {
          university: wish.university,
        }
      end
    end

    def create
      wish = Wish.new({
        user_id: @current_user.id,
        university_id: params[:university_id]
      })

      if wish.save
        render json: wish, status: 201
      else
        render json: {}, status: 400
      end
    end

    def destroy
      wish = Wish.find(params[:id])
      if wish && @current_user.wishes.include?(wish) && wish.destroy
        render json: {}, status: 200
      else
        render json: {}, status: 400
      end
    end
  end
end
