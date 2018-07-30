require 'rails_helper'
require "support/authorization_helpers"
require "support/pundit_matcher"

RSpec.describe TicketPolicy do

  let(:user) { User.new }

  subject { TicketPolicy }


  context "permissions" do
    subject { TicketPolicy.new(user, ticket) }

    let(:user) { FactoryGirl.create(:user) }
    let(:project) { FactoryGirl.create(:project) }
    let(:ticket) { FactoryGirl.create(:ticket, project: project) }

    context "for anonymous users" do
      let(:user) { nil }

      it { should_not permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }

      it { should_not permit_action :change_state }

      it { should_not permit_action :tag }
    end

    context "for viewers of the project" do
      before { assign_role!(user, :viewer, project) }

      it { should permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }

      it { should_not permit_action :change_state }

      it { should_not permit_action :tag }
    end

    context "for editors of the project" do
      before { assign_role!(user, :editor, project) }

      it { should permit_action :show }
      it { should permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }

      it { should_not permit_action :change_state }

      it { should_not permit_action :tag }

      context "when the editor created the ticket" do
        before { ticket.author = user }

        it { should permit_action :update }
        it { should_not permit_action :destroy }
      end
    end

    context "for managers of the project" do
      before { assign_role!(user, :manager, project) }

      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should permit_action :destroy }

      it { should permit_action :change_state }

      it { should permit_action :tag }
    end

    context "for managers of other projects" do
      before do
        assign_role!(user, :manager, FactoryGirl.create(:project))
      end

      it { should_not permit_action :show }
      it { should_not permit_action :create }
      it { should_not permit_action :update }
      it { should_not permit_action :destroy }

      it { should_not permit_action :change_state }

      it { should_not permit_action :tag }
    end

    context "for administrators" do
      let(:user) { FactoryGirl.create :user, :admin }

      it { should permit_action :show }
      it { should permit_action :create }
      it { should permit_action :update }
      it { should permit_action :destroy }

      it { should permit_action :change_state }

      it { should permit_action :tag }
    end
  end


  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
