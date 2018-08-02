class API::TicketsController < ApplicationController
  attr_reader :current_user

  before_action :authenticate_user
  before_action :set_project
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized


  def show
    @ticket = @project.tickets.find(params[:id])
    authorize @ticket, :show?

    render json: @ticket, root: true, adapter: :json
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def not_authorized
    redirect_to root_path, alert: "You aren't allowed to do that."
  end

  def authenticate_user
    authenticate_with_http_token do |token|
      @current_user = User.find_by(api_key: token)
    end
  end
end
