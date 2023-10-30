class CandidatesController < ApplicationController
    #I have no idea why, but without these, the candidate list keeps switching order
    #Also, these find ids.
    before_action :find_election
    #Add function at the end here
    before_action :find_candidate, only: [:show, :edit, :update, :destroy, :increment_votes, :add_votes]

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

    def checkInput
        @candidate = Election.find(params[:commit])
        @candidate.description = "hello "
    end

    def increment_votes
        candidate = Candidate.find(params[:candidate_id]) #Takes candidate_id from form
        candidate.increment(:voteCount) #Instead of increment, can call method declared in candidate.rb
        candidate.save 
        redirect_to election_path(candidate.election)
      end

private
    def candidate_params
        params.require(:candidate).permit(:name, :description)
    end

    #I have no idea why, but without these, the candidate list keeps switching order
    def find_election
        puts "A" 
        puts params
        @election = Election.find(params[:election_id])
    end

    def find_candidate
        puts "B" 
        puts params
        @candidate = @election.candidates.find(params[:candidate_id])
    end
end
