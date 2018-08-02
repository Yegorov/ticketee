class API::ApplicationController < ApplicationController
  attr_reader :current_user
  before_action :authenticate_user

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  private
  def not_authorized
    #redirect_to root_path, alert: "You aren't allowed to do that."
    render json: { error: "Unauthorized" }, status: 403
  end

  def authenticate_user
    authenticate_with_http_token do |token|
      @current_user = User.find_by(api_key: token)
    end

    if @current_user.nil?
      render json: { error: "Unauthorized" }, status: 401
      return
    end
  end
end
