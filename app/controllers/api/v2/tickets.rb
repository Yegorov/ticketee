require "sinatra"
require 'pp'


module API
  module V2
    class Tickets < Sinatra::Base
      before do
        headers "Content-Type" => "text/json"
        set_user
        set_project
      end

      get "/:id" do
        ticket = @project.tickets.find(params[:id])
        TicketSerializer.new(ticket).to_json
      end

      private

      def params
        hash = env["action_dispatch.request.path_parameters"].merge!(super)
        HashWithIndifferentAccess.new(hash)
      end

      def set_project
        @project = Project.find(params[:project_id])
      end

      def set_user
        if env["HTTP_AUTHORIZATION"].present?
          auth_token = /Token token=(.*)/.match(env["HTTP_AUTHORIZATION"])[1]

          User.find_by!(api_key: auth_token)
        end
      end
    end
  end
end
