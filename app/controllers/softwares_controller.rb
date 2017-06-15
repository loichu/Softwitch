class SoftwaresController < ApplicationController
  def index
    @softwares = Software.all
  end

  def show
    @software = Software.find(params[:id])
    @editor = @software.editor
  end

  def new
    @software = Software.new
    @version = Version.new
    #@version.build_software
    @editors = Editor.all
  end

  def edit
    @sofware = Software.find(params[:id])
  end

  def create
    @editors = Editor.all

    @software = Software.new(software_params)

    if @software.save
      @version = @software.versions.create(version_params)

      if @version.save
        redirect_to @software
      end

    else
      render 'new'
    end
  end

  def update
    @software = Software.find(params[:id])

    if @software.update(software_params)
      redirect_to @software
    else
      render 'new'
    end
  end

  private
    def version_params
      params.require(:version).permit(:name, :website)
    end

    def software_params
      params.require(:software).permit(:name, :editor_id)
    end
end
