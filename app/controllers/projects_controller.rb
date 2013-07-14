class ProjectsController < ApplicationController
    
    before_filter :find_project, :only => [:show,
    :edit,
    :update,
    :destroy]
    
    
  def index
      @projects = Project.all
  end

  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    if @project.save
        flash[:notice] = "Project has been created."
        redirect_to @project
    else
        flash[:alert] = "Project has not been created."
        render :action => "new"
    end
  end
            
  def show
    #due to addition of the before_filter code - next line not needed
    #@project = Project.find(params[:id])
  end
  
  def edit
      #due to addition of the before_filter code - next line not needed
      #@project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
        flash[:notice] = "Project has been updated."
        redirect_to @project
    else
        flash[:alert] = "Project has not been updated."
        render :action => "edit"
    end
  end
  
  def destroy
    #due to addition of the before_filter code - next line not needed
    #@project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Project has been deleted."
    redirect_to projects_path
  end
  
  # This is for getting a nicer message than page not found or a 404
  private
    def find_project
    @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The project you were looking" +
    " for could not be found."
    redirect_to projects_path
    end
end
