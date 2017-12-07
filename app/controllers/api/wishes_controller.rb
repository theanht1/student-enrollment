module Api
  class WishesController < Api::ApiController
    def index
      res = @current_user.wishes.order(:order).includes(:university).map(&:wish_response)
      render json: res
    end

    def create
      wish = Wish.new({
        user_id: @current_user.id,
        university_id: params[:university_id],
        order: @current_user.wishes.length,
      })

      if wish.save
        render json: wish.wish_response, status: 201
      else
        render json: wish.errors.full_messages, status: 400
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

    def order
      wish_ids = params[:wishes]

      @current_user.wishes.each do |wish|
        wish.update(order: wish_ids.index(wish.id))
      end

      render json: {}
    end
  end
end
