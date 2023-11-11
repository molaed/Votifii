class CandidatesController < ApplicationController

    before_action :authenticate_user!
    
    def create
        @election = Election.find(params[:election_id])
        if @election.user == current_user #Make sure they have permission
            #@election.update_attribute(:candidateCount, @election.candidateCount + 1)
            @candidate = @election.candidates.create(candidate_params)
            redirect_back(fallback_location: root_path)
        end
    end
    def destroy
        @election = Election.find(params[:election_id])
        if @election.user == current_user #Make sure they have permission
            #@election.update_attribute(:candidateCount, @election.candidateCount - 1)
            @candidate = @election.candidates.find(params[:id])
            @candidate.destroy
            redirect_to edit_election_path(@election), status: :see_other
        end
    end

    def checkInput
        @candidate = Election.find(params[:commit])
        @candidate.description = "hello "
    end

    def increment_votes #Increments 
        candidate = Candidate.find(params[:candidate_id]) #Takes candidate_id from form
        candidate.increment(:voteCount) #Instead of increment, can call method declared in candidate.rb
        candidate.save 
        redirect_to election_path(candidate.election)
      end

private
    def candidate_params
        params.require(:candidate).permit(:name, :description)
    end
end
