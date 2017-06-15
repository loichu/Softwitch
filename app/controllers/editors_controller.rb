class EditorsController < ApplicationController
  def index
    @editors = Editor.all
  end

  def show
    @editor = Editor.find(params[:id])
  end

  def new
    @editor = Editor.new
  end

  def create
    @editor = Editor.new(editor_params)

    if @editor.save
      redirect_to @editor
    else
      render 'new'
    end

  end

  private
    def editor_params
      params.require(:editor).permit(:name, :website)
    end
end
