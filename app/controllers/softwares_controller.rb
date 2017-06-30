class SoftwaresController < ApplicationController
  before_action :set_software, only: [:show, :edit, :update, :destroy]

  # GET /softwares
  # GET /softwares.json
  def index
    @softwares = Software.all
  end

  # GET /softwares/1
  # GET /softwares/1.json
  def show
    @editor = @software.editor
    @versions = @software.versions
  end

  # GET /softwares/new
  def new
    @software = Software.new
    @software.versions.build
    @editors = Editor.all
    @os = OperatingSystem.all
  end

  # GET /softwares/1/edit
  def edit
    @editors = Editor.all
  end

  # POST /softwares
  # POST /softwares.json
  def create
    @software = Software.new(software_params)

    respond_to do |format|
      if @software.save
        @version = @software.versions.create(version_params)
        if @version.save
          format.html { redirect_to @software, notice: 'Software was successfully created.' }
          format.json { render :show, status: :created, location: @software }
        else
          format.html { render :new }
          format.json { render json: @software.errors, status: :unprocessable_entity}
        end
      end
    end
  end

  # PATCH/PUT /softwares/1
  # PATCH/PUT /softwares/1.json
  def update
    respond_to do |format|
      if @software.update(software_params)
        format.html { redirect_to @software, notice: 'Software was successfully updated.' }
        format.json { render :show, status: :ok, location: @software }
      else
        format.html { render :edit }
        format.json { render json: @software.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /softwares/1
  # DELETE /softwares/1.json
  def destroy
    @software.destroy
    respond_to do |format|
      format.html { redirect_to softwares_url, notice: 'Software was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_software
    @software = Software.find(params[:id])
  end

  def version_params
    params.require(:version).permit(:name, :website, :distrilog, :date, :install_link, { operating_system_ids:[] })
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def software_params
    params.require(:software).permit(:name, :editor_id, :short_desc)
  end
end
