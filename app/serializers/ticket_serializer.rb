class TicketSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :project_id, :created_at,
   :updated_at, :author_id, :state_id

   has_on :state
end
