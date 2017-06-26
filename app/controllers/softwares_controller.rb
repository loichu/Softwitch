class SoftwaresController < ApplicationController
  include SoftwaresHelper

  def index
    @softwares = Software.all
    CheckAllCompatibility(@softwares) #HANDLE THIS SHIT
  end

  def show
    @software = Software.find(params[:id])
    @editor = @software.editor
  end

  def new
    @software = Software.new
    @software.versions.build
    @editors = Editor.all
    @os = OperatingSystem.all
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
      redirect_to new_software_url
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
      params.require(:version).permit(:name, :website, :distrilog, :date, :install_link, { operating_system_ids:[] })
    end

    def software_params
      params.require(:software).permit(:name, :editor_id, :short_desc)
    end
end
