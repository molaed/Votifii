class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    #Creates Comment
    @election = Election.find(params[:election_id])
    @candidate = @election.candidates.find(params[:candidate_id])
    @comment = @candidate.comments.create(comment_params.merge(user: current_user))

    redirect_to election_path(@election)  # Redirect to the election's path
  end

  def update
    #Update Comment
    @election = Election.find(params[:election_id])
    @candidate = @election.candidates.find(params[:candidate_id])
    @comment = @candidate.comments.find(params[:id])
    @comment.update(comment_params)
    redirect_to election_path(@election)
  end

  def destroy
    #Destroy Comment
    @election = Election.find(params[:election_id])
    @candidate = @election.candidates.find(params[:candidate_id])
    @comment = @candidate.comments.find(params[:id])
    @comment.destroy
    redirect_to election_path(@election)
  end


  private

  def comment_params
    params.require(:comment).permit(:content, :election_id)
  end
end