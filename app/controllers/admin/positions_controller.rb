class Admin::PositionsController < Admin::BaseController
    def index
      @positions = Position.order(:priority)
    end
  
    def new
      @position = Position.new
    end
  
    def create
      @position = Position.new(position_params)
      if @position.save
        redirect_to admin_positions_path, notice: "Position created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      @position = Position.find(params[:id])
    end
  
    def update
      @position = Position.find(params[:id])
      if @position.update(position_params)
        redirect_to admin_positions_path, notice: "Position updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @position = Position.find(params[:id])
      if @position.votes.any?
        redirect_to admin_positions_path, alert: "Cannot delete a position with votes."
      else
        @position.destroy
        redirect_to admin_positions_path, notice: "Position deleted successfully."
      end
    end
  
    private
  
    def position_params
      params.require(:position).permit(:name, :description, :max_winners, :priority, :voting_open)
    end
  end