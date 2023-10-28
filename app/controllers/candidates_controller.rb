class CandidatesController < ApplicationController
    def create
        @election = Election.find(params[:election_id])
        @candidate = @election.candidates.create(candidate_params)
        redirect_to election_path(@election)
        end
    def destroy
        @election = Election.find(params[:election_id])
        @candidate = @election.candidates.find(params[:id])
        @candidate.destroy
        redirect_to election_path(@election), status: :see_other
    end

private
    def candidate_params
        params.require(:candidate).permit(:name, :description)
    end
end