class VersionsController < ApplicationController
  before_action :set_version, only: [:show, :edit, :update, :destroy]

  # GET /programs/:program_id/versions
  # GET /programs/:program_id/versions.json
  def index
    @versions = Version.where(:program_id => params[:program_id])
  end

  # GET /versions/1
  # GET /versions/1.json
  def show
    @version = Version.find(params[:id])
  end

  # GET /programs/:program_id/versions/new
  def new
    @program = Program.find params[:program_id]
    @os = OperatingSystem.all
    @version = Version.new
  end

  # GET /versions/1/edit
  def edit
    @os = OperatingSystem.all
    @program = @version.program
  end

  # POST /programs/:program_id/versions
  # POST /programs/:program_id/versions.json
  def create
    @program = Program.find params[:program_id]
    @version = @program.versions.create(version_params)

    respond_to do |format|
      if @version.save
        format.html { redirect_to @program, notice: 'Version was successfully created.' }
        format.json { render :show, status: :created, location: @version }
      else
        format.html { render :new }
        format.json { render json: @version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /versions/1
  # PATCH/PUT /versions/1.json
  def update
    respond_to do |format|
      if @version.update(version_params)
        format.html { redirect_to @version, notice: 'Version was successfully updated.' }
        format.json { render :show, status: :ok, location: @version }
      else
        format.html { render :edit }
        format.json { render json: @version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /versions/1
  # DELETE /versions/1.json
  def destroy
    @version.destroy
    respond_to do |format|
      format.html { redirect_to versions_url, notice: 'Version was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_version
    @version = Version.find(params[:id])
  end

  def version_params
    params.require(:version).permit(:name, :website, :distrilog, :date, :install_link, { operating_system_ids:[] })
  end

  # It's useless because of the nested routes
  def check_program
    if params[:program_id] == nil
      redirect_to programs_url, :flash => { :error => "A version must correspond to a program"}
    end
  end
end
