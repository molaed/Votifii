class CandidatesController < ApplicationController

    before_action :authenticate_user!, except: :increment_votes
    
    def create
        @election = Election.find(params[:election_id])

        if @election.user == current_user #Make sure they have permission
            #@election.update_attribute(:candidateCount, @election.candidateCount + 1)
            @candidate = @election.candidates.create(candidate_params)
            #@candidate.profile_image = "d"
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

    def increment_votes
        candidate = Candidate.find(params[:candidate_id])
        
        # Check if the user has already voted in this election
        voted_elections = session[:voted_elections] || []
        unless voted_elections.include?(candidate.election_id)
          candidate.increment(:voteCount)
          candidate.save
    
          # Mark the election as voted
          voted_elections << candidate.election_id
          session[:voted_elections] = voted_elections
        end
    
        redirect_to election_path(candidate.election)
      end

private
    def candidate_params
        params.require(:candidate).permit(:name, :description, :profile_image, :speech)
    end
end
