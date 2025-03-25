class PositionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_voting_status, only: [:index, :show, :vote]

  def index
    @position = Position.where(voting_open: true).order(:priority).first
    if @position
      redirect_to position_path(@position)
    else
      redirect_to root_path, alert: "No positions are currently open for voting."
    end
  end

  def show
    @position = Position.find(params[:id])
    @candidates = @position.candidates
    @user_votes = current_user.votes.where(position: @position, status: "draft").pluck(:candidate_id)

    @next_position = Position.where(voting_open: true).where("priority > ?", @position.priority).order(:priority).first
    @previous_position = Position.where(voting_open: true).where("priority < ?", @position.priority).order(:priority).last
  end

  def vote
    @position = Position.find(params[:id])
    selected_candidate_ids = Array(params[:candidate_ids])

    # Validate the number of selections for multi-winner positions
    if selected_candidate_ids.count > @position.max_winners
      redirect_to position_path(@position), alert: "You can only select up to #{@position.max_winners} candidates."
      return
    end

    # Validate that selected candidate IDs belong to this position
    valid_candidate_ids = @position.candidates.pluck(:id).map(&:to_s)
    invalid_ids = selected_candidate_ids - valid_candidate_ids
    if invalid_ids.any?
      redirect_to position_path(@position), alert: "Invalid candidate selection."
      return
    end

    # Delete existing draft votes for this position
    current_user.votes.where(position: @position, status: "draft").destroy_all

    # Create new draft votes only if candidates were selected
    if selected_candidate_ids.any?
      selected_candidate_ids.each do |candidate_id|
        current_user.votes.create!(
          candidate_id: candidate_id,
          position: @position,
          status: "draft"
        )
      end
    end

    # Redirect to the next position or a summary page
    next_position = Position.where(voting_open: true).where("priority > ?", @position.priority).order(:priority).first
    if next_position
      redirect_to position_path(next_position), notice: "Your vote has been saved."
    else
      redirect_to root_path, notice: "You have completed voting for all positions. Please submit your votes."
    end
  end

  private

  def check_voting_status
    if current_user.has_voted
      redirect_to root_path, alert: "You have already submitted your votes."
    end
  end
end