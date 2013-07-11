class ProjectsController < ApplicationController
  def index
  end

  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project]) # <co id="ch03_551_1"/>
    if @project.save
    flash[:notice] = "Project has been created."
    redirect_to @project
    else
    # nothing, yet
    end
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
end
