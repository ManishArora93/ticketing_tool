class Ticket < ActiveRecord::Base

  #Validations
  validates :name, presence: true
  validates :description, presence: true
  validates :severity, presence: true
  validates :status, presence: true

  def self.to_csv(ticket_ids)
    CSV.generate do |csv|
      csv << ['Ticket_ID', 'Ticket Name', 'Ticket Description', 'Customer Username', 'Handled by Associate', 'Created AT']
      ticket_ids.each do |id|
        ticket = Ticket.where(id: id).first
        if ticket.present?
          csv <<  [ ticket.id,
                    ticket.name,
                    ticket.description,
                    User.where(id: ticket.customer_id).first.try(:username),
                    User.where(id: ticket.associate_id).first.try(:email),
                    ticket.created_at
                  ]
        end
      end
    end
  end
end
