class MembersController < ApplicationController
  before_action :set_member, only: [ :show, :edit, :update, :destroy ]
  # If you are not the user who creates the member, you are not authorized to edit it.
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /members or /members.json
  def index
    if current_user
      if current_user.team
        @members = current_user.team.members
      end
    else
      redirect_to new_user_registration_path, notice:"Register First"
    end
  end

  # GET /members/1 or /members/1.json
  def show
  end

  # GET /members/new
  def new
    if current_user.team
      @member = current_user.team.members.new
    else
      redirect_to new_team_path, notice:"You must be part of a team"
    end
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members or /members.json
  def create
    if current_user.team
      @member = current_user.team.members.build(member_params)

      respond_to do |format|
        if @member.save
          format.html { redirect_to member_url(@member), notice: "Member was successfully created." }
          format.json { render :show, status: :created, location: @member }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @member.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_team_path, notice: "You must be part of a team to create members."
    end
  end

  # PATCH/PUT /members/1 or /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to member_url(@member), notice: "Member was successfully updated." }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1 or /members/1.json
  def destroy
    @member.destroy!

    respond_to do |format|
      format.html { redirect_to members_url, notice: "Member was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @member = current_user.team.members.find_by(id: params[:id])
    redirect_to members_path, notice: "Not Authorized to Edit This Member" if @member.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = current_user.team.members.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:first_name, :last_name, :spicy, :healthy, :team_id)
    end
end
