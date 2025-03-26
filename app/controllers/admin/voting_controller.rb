class Admin::VotingController < Admin::BaseController
    def toggle
      new_status = params[:status] == "open"
      Position.update_all(voting_open: new_status)
      redirect_to admin_dashboard_path, notice: "Voting has been #{new_status ? 'opened' : 'closed'} for all positions."
    end
  
    def reset
      Vote.delete_all
      User.update_all(has_voted: false)
      redirect_to admin_dashboard_path, notice: "Voting has been reset successfully."
    end
  end