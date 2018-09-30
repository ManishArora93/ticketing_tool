json.extract! ticket, :id, :name, :description, :severity, :status, :customer_id, :associate_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)