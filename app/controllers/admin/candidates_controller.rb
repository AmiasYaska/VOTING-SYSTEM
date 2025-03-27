class Admin::CandidatesController < Admin::BaseController
    def index
      @position = Position.find(params[:position_id]) if params[:position_id].present?
      @positions = Position.all
      @candidates = @position ? @position.candidates : Candidate.all
    end
  
    def new
      @position = Position.find(params[:position_id]) if params[:position_id].present?
      @candidate = Candidate.new(position: @position)
    end
  
    def create
      @candidate = Candidate.new(candidate_params)
      if @candidate.save
        redirect_to admin_candidates_path(position_id: @candidate.position_id), notice: "Candidate created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      @candidate = Candidate.find(params[:id])
    end
  
    def update
      @candidate = Candidate.find(params[:id])
      if @candidate.update(candidate_params)
        redirect_to admin_candidates_path(position_id: @candidate.position_id), notice: "Candidate updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @candidate = Candidate.find(params[:id])
      if @candidate.votes.any?
        redirect_to admin_candidates_path(position_id: @candidate.position_id), alert: "Cannot delete a candidate with votes."
      else
        @candidate.destroy
        redirect_to admin_candidates_path(position_id: @candidate.position_id), notice: "Candidate deleted successfully."
      end
    end
  
    private
  
    def candidate_params
      params.require(:candidate).permit(:position_id, :name, :qualification, :photo)
    end
  end