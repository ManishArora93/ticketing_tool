class TicketsController < ApplicationController
  
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if current_user.custom_roles.pluck(:title).include?('admin')
      get_all_tickets
    elsif current_user.custom_roles.pluck(:title).include?('associate')
      get_all_tickets
    else
      @tickets = Ticket.where(customer_id: current_user.id)
      respond_with(@tickets)
    end
  end

  def get_all_tickets
    @tickets = Ticket.all
    respond_with(@tickets)
  end

  def show
    respond_with(@ticket)
  end

  def new
    @ticket = Ticket.new
    respond_with(@ticket)
  end

  def edit
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.save
    respond_with(@ticket)
  end

  def update
    @ticket.update(ticket_params)
    respond_with(@ticket)
  end

  def destroy
    @ticket.destroy
    respond_with(@ticket)
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:name, :description, :severity, :status, :customer_id, :associate_id, :comment)
    end
end
