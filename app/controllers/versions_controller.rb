class VersionsController < ApplicationController
  # GET /softwares/:software_id/versions
  # GET /softwares/:software_id/versions.json
  def index
    @versions = Version.all
  end

  # GET /versions/1
  # GET /versions/1.json
  def show
    @version = Version.find(params[:id])
  end

  # GET /softwares/:software_id/versions/new
  def new
    @software = Software.find params[:software_id]
    @os = OperatingSystem.all
    @version = Version.new
  end

  # GET /versions/1/edit
  def edit
    @software = Software.find(params[:software_id])
  end

  # POST /softwares/:software_id/versions
  # POST /softwares/:software_id/versions.json
  def create
    @software = Software.find params[:software_id]
    @version = @software.versions.create(version_params)

    respond_to do |format|
      if @version.save
        format.html { redirect_to @software, notice: 'Version was successfully created.' }
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
end
