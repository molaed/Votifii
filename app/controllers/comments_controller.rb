class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @election = Election.find(params[:election_id])
    @candidate = @election.candidates.find(params[:candidate_id])
    @comment = @candidate.comments.create(comment_params)
    @candidate.save
    current_user.save
    @election.save
    redirect_to election_candidate_path(@election, @candidate)
  end

  def destroy
    @election = Election.find(params[:election_id])
    @candidate = @election.candidates.find(params[:candidate_id])
    @comment = @candidate.comments.find(params[:id])
    @comment.destroy
    redirect_to election_candidate_path(@election, @candidate)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end