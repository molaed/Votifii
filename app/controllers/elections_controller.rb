class ElectionsController < ApplicationController
  def index
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
    @election = Election.new(election_params)

    if @election.save
      redirect_to @election
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @election = Election.find(params[:id])
  end

  def update
    @election = Election.find(params[:id])

    if @election.update(election_params)
      redirect_to @election
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @election = Election.find(params[:id])
    @election.destroy

    redirect_to root_path, status: :see_other
  end

  def end
    @election = Election.find(params[:id])
    redirect_to election_path(@election)
  end

  private
    def election_params
      params.require(:election).permit(:title, :description)
    end
end
