class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
    #@project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def edit
    #@project = Project.find(params[:id])
  end

  def update
    #@project = Project.find(params[:id])
    #@project.update_attributes(project_params)
    @project.update(project_params)
    if @project.save
      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash.now[:alert] = "Project has not been updated."
      render "edit"
    end
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to @project
    else
      flash.now[:alert] = "Project has not been created."
      render "new"
    end
  end

  def destroy
    #@project = Project.find(params[:id])
    @project.destroy

    redirect_to projects_path, notice: "Project has been deleted."
  end

  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The project you were looking for could not be found."
    redirect_to projects_path
  end
  
  private
  def project_params
    params.require(:project).permit(:name, :description)
  end
end
