## date date
## distrilog boolean
## installLink string
## name string
## presentation string
## software_id integer FK
## website string

class VersionsController < ApplicationController
  def index
    check_software
    @versions = Version.all
  end

  def show
    @version = Version.find(params[:id])
  end

  def new
    check_software
    @software = Software.find params[:software_id]
    #@software.versions.build
    @os = OperatingSystem.all
    @version = Version.new
    #@version.software = Software.find(params[:software_id])
  end

  def create
    @software = Software.find params[:software_id]
    @version = @software.versions.create(version_params)

    if @version.save
      redirect_to software_path(@software)
    else
      Rails.logger.info(@version.errors.inspect)
      render 'new'
    end
  end

  def update
    @version = Version.find(params[:id])

    if @version.update(version_params)
      redirect_to @version
    else
      render 'new'
    end
  end

  def get_details
    @version = Version.find params[:id]
    render :json => @version
  end

  private

  def version_params
    params.require(:version).permit(:name, :website)
  end

  def check_software
    if params[:software_id] == nil
      redirect_to softwares_url, :flash => { :error => "A version must correspond to a software"}
    end
  end
end
