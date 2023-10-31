class CandidatesController < ApplicationController
    #I have no idea why, but without these, the candidate list keeps switching order
    #Also, these find ids.
    before_action :find_election
    #Add function at the end here
    before_action :find_candidate, only: [:show, :edit, :update, :destroy, :increment_votes]

    def create
        @election = Election.find(params[:election_id])
        @election.update_attribute(:candidateCount, @election.candidateCount + 1)
        @candidate = @election.candidates.create(candidate_params)
        redirect_back(fallback_location: root_path)
    end
    def destroy
        @election = Election.find(params[:election_id])
        @election.update_attribute(:candidateCount, @election.candidateCount - 1)
        @candidate = @election.candidates.find(params[:id])
        @candidate.destroy
        redirect_to election_path(@election), status: :see_other
    end

    def checkInput
        @candidate = Election.find(params[:commit])
        @candidate.description = "hello "
    end

    def increment_votes #Increments 
        #puts outputs to console, useful. Also, typing rails console, then Candidate.all lists all candidates and variables
        #puts "Election ID: #{params[:election_id]}"
        #puts "Candidate ID: #{params[:id]}"
        @candidate = Candidate.find(params[:id])
        @candidate.increment(:voteCount) #Instead of increment, can call method declared in candidate.rb
        @candidate.save
        redirect_to election_path(@candidate.election)
    end

private
    def candidate_params
        params.require(:candidate).permit(:name, :description)
    end

    #I have no idea why, but without these, the candidate list keeps switching order
    def find_election
        @election = Election.find(params[:election_id])
    end

    def find_candidate
        @candidate = @election.candidates.find(params[:id])
    end
end
