class ElectionsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @users_with_elections = User.joins(:elections).distinct
    @elections = Election.all
  end

  def show
    @election = Election.find(params[:id])
    # @names = Candidate.all.select(:name).map(&:name)
    @candidates = @election.candidates
  end

  def new
    @election = Election.new
  end

  def create
    @election = current_user.elections.new(election_params)
    #puts "#{@election.title}, #{@election.description}, #{@election.winner_id == nil}, #{@election.status == nil}"
    if @election.save
     # puts "election created!"
      redirect_to @election
    else
      #puts "election NOT created!"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @election = Election.find(params[:id])
  end

  def update
    @election = Election.find(params[:id])
    if @election.user == current_user #Make sure they have permission
      if @election.update(election_params)
        redirect_to @election
        
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @election = Election.find(params[:id])
    if @election.user == current_user #Make sure they have permission
      @election.destroy

      redirect_to root_path, status: :see_other
    end
  end

  def find_winners(candidates)
    max_vote_count = @candidates.maximum(:voteCount)
    cands_with_max_votes = @candidates.where(voteCount: max_vote_count)
    cands_with_max_votes
  end

  def end
    @election = Election.find(params[:id])
    if @election.user == current_user #Make sure they have permission
      
      @candidates = @election.candidates
      # @winner = @candidates.max_by(&:voteCount)
      @winners = find_winners(@candidates)

      # if @winner
      #   @election.update(winner_id: @winner.id)
      # else
      #   @election.update(winner_id: nil)
      # end
      # puts "winner is: #{@election.winner_id}"


      if @winners.length == 1 # if one winner, end election
        @election.update(winner_id: @winners.first.id)
        @election.archive_election
      else  # if more than one person, then nobody wins
        @election.update(winner_id: nil)
      end
      redirect_to election_path(@election)
    end
  end

  

  private
    def election_params
      params.require(:election).permit(:title, :description)
    end
end

# test merge 