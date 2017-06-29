## date date
## distrilog boolean
## installLink string
## name string
## presentation string
## software_id integer FK
## website string

class VersionsController < ApplicationController
  def index
    @versions = Version.all
  end

  def show
    @version = Version.find(params[:id])
  end

  def new
    @software = Software.find params[:software_id]
    @os = OperatingSystem.all
    @version = Version.new
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
    render :json => Version.find(params[:id])
  end

  private

  def version_params
    params.require(:version).permit(:name, :website, :distrilog, :date, :install_link, { operating_system_ids:[] })
  end

  # It's useless because of the nested routes
  def check_software
    if params[:software_id] == nil
      redirect_to softwares_url, :flash => { :error => "A version must correspond to a software"}
    end
  end
end
