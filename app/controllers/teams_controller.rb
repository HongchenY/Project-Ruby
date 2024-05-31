class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /teams or /teams.json
  def index
    @team = Team.all
  end

  # GET /teams/1 or /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    if current_user.team
      redirect_to teams_path, notice:"You are already in a team"
    else
      @team = Team.new
    end
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams or /teams.json
  def create
    if current_user.team
      redirect_to team_path(current_user.team), notice:"You are already in a team"
      return
    end

    @team = Team.new(team_params)


    if params[:create]
      current_user.team=@team
      if current_user.save
        redirect_to team_path(@team), notice:"Team created successfully."
      else
        render :new
      end
    elsif params[:join]
      existing_team = Team.find_by(teamName: params[:teamName], code: params[:code])
      if existing_team
        current_user.team = existing_team
        if current_user.save
          redirect_to team_path(existing_team), notice:"Succesfully joined team" + @team.teamName
        else
          render :new
        end
      else
        redirect_to new_team_path, notice:"The team does not exist"
      end
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to team_url(@team), notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy!

    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
      
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:teamName, :code)
    end

end
