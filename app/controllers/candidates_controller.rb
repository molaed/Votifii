class CandidatesController < ApplicationController
    
    def create
        @election = Election.find(params[:election_id])
       # @election.update_attribute(:candidateCount, @election.candidateCount + 1)
        @candidate = @election.candidates.create(candidate_params)
        redirect_back(fallback_location: root_path)
    end
    def destroy
        @election = Election.find(params[:election_id])
       # @election.update_attribute(:candidateCount, @election.candidateCount - 1)
        @candidate = @election.candidates.find(params[:id])
        @candidate.destroy
        redirect_to election_path(@election), status: :see_other
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
