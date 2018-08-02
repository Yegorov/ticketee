require 'rails_helper'
require "support/authorization_helpers"

RSpec.describe API::V2::Tickets do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:state) { FactoryGirl.create(:state, name: "Open") }
  let(:ticket) do
    FactoryGirl.create(:ticket, project: project, state: state)
  end
  let(:url) { "/api/v2/projects/#{project.id}/tickets/#{ticket.id}" }
  let(:headers) do
      { "HTTP_AUTHORIZATION" => "Token token=#{user.api_key}" }
    end

  before do
    assign_role!(user, :manager, project)
    user.generate_api_key
  end

  context "successful requests" do
    it "can view a ticket's details" do
      get url, {}, headers

      expect(response.status).to eq 200
      json = TicketSerializer.new(ticket).to_json
      expect(response.body).to eq json
    end
  end
end
