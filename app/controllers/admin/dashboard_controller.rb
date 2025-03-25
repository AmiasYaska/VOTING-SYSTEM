class Admin::DashboardController < Admin::BaseController
    def index
      @total_positions = Position.count
      @total_candidates = Candidate.count
      @total_users = User.count
      @users_voted = User.where(has_voted: true).count
      @users_not_voted = @total_users - @users_voted
      @open_positions = Position.where(voting_open: true).count
    end
  end