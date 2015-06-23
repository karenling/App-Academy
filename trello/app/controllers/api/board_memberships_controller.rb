module Api
  class BoardMembershipsController < ApiController

    def index
      @board_memberships = BoardMembership.all

      render json: @board_memberships

    end

    def create
        user = User.find_by(email: params[:board_membership][:email])

        if user
          @board_membership = BoardMembership.new(user_id: user.id, board_id: params[:board_membership][:board_id]);

          if @board_membership.save
            render json: @board_membership
          else
            render json: @board_membership.errors.full_messages, status: :unprocessable_entity
          end
        else
          render json: "User doesn't exist"
        end



    end




    private
      def board_mem_params
        params.require(:board_membership).permit(:user_id, :board_id)
      end
  end
end
