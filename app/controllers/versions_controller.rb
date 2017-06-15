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
    @version = Version.new
  end

  def create
    @version = Version.new(version_params)

    if @version.save
      redirect_to @version
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

  private
  def version_params
    params.require(:version).permit(:name, :website)
  end
end
