class Admin::ResultsController < Admin::BaseController
    def index
      @positions = Position.all
      @results = {}
  
      @positions.each do |position|
        @results[position.id] = position.candidates.map do |candidate|
          vote_count = candidate.votes.where(status: "submitted").count
          [candidate, vote_count]
        end.sort_by { |_, count| -count }
      end
  
      respond_to do |format|
        format.html
        format.csv { send_data generate_csv, filename: "voting_results_#{Date.today}.csv" }
      end
    end
  
    private
  
    def generate_csv
      CSV.generate(headers: true) do |csv|
        csv << ["Position", "Candidate", "Vote Count", "Winner"]
        @positions.each do |position|
          results = @results[position.id]
          winners = results.first(position.max_winners).map { |candidate, _| candidate.id }
          results.each do |candidate, vote_count|
            csv << [position.name, candidate.name, vote_count, winners.include?(candidate.id) ? "Yes" : "No"]
          end
        end
      end
    end
  end