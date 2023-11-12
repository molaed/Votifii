class CandidatesController < ApplicationController

    before_action :authenticate_user!, except: :increment_votes
    
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
        @election = Election.find(params[:election_id])
        if params[:candidate_id] != "-1" #If -1, means abstain
            candidate = Candidate.find(params[:candidate_id]) #Takes candidate_id from form
    
            if !candidate.voters.include?(current_user.id) #If current_user hasn't voted for this candidate
                candidate.increment(:voteCount) #Instead of increment, can call method declared in candidate.rb
                @election.candidates.each { |otherCandidate| # If current_user has voted for someone else, prevent them
                    if otherCandidate != candidate && otherCandidate.voters.include?(current_user.id)
                        otherCandidate.decrement(:voteCount)
                        # Add the current user to the voters array
                        otherCandidate.voters.delete(current_user.id)
                        # Save the record to persist the changes
                        otherCandidate.save 
                    end
                }
                #Add current user to the record
                # Add the current user to the voters array
                candidate.voters << current_user.id
                # Save the record to persist the changes
                candidate.save 
                
            end
        else
            @election.candidates.each { |candidate| # If current_user has voted for someone else, remove them
                if candidate.voters.include?(current_user.id)
                    candidate.decrement(:voteCount)
                    # Add the current user to the voters array
                    candidate.voters.delete(current_user.id)
                    # Save the record to persist the changes
                    candidate.save 
                end
            }
        end
        redirect_to election_path(@election)
    end

private
    def candidate_params
        params.require(:candidate).permit(:name, :description, :image_link, :speech)
    end
end
