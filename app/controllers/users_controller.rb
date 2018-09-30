require 'csv'
require 'prawn'
class UsersController < ApplicationController
  # Public: /users Display all Users
  #
  # Render index action
  def index
    @user = User.page(params[:page]).per(5)
  end

  # Public: /users/:id/edit Edit user details
  #
  # Params: user id 
  #
  # Render edit action
	def edit
     @user=User.find(params[:id])
  end

  # Public:PATCH
  #
  # Params: The form params
  #
  # Render edit
  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to questions_path
    else
      render 'edit'
      flash[:danger]="cannot updated"
    end
  end

  def admin_setting
  end

  def export_report
  end

  def export_all_tickets_report
    ticket_ids = Ticket.where("tickets.created_at > ?", 1.month.ago).where(status: params[:status]).pluck(:id)
    respond_to do |format|
      format.csv { send_data Ticket.to_csv(ticket_ids) }
      pdf = Prawn::Document.new
      pdf.text(Ticket.to_csv(ticket_ids))
      ticket_report = pdf.render_file('csv.pdf')
      format.pdf {send_data ticket_report}
    end
  end

  def update_role
    @user = User.find(params[:change_role][:id])
    @user.custom_roles.delete_all
    if params[:role_ids].present?
      if params[:role_ids].include?('user')
        @user.make_as_user
      else
        @user.custom_roles.delete(Role.send(:user))
      end
      if params[:role_ids].include?('admin')
        @user.make_as_admin
      else
        @user.custom_roles.delete(Role.send(:admin))
      end
      if params[:role_ids].include?('associate')
        @user.make_as_associate
      else
        @user.custom_roles.delete(Role.send(:associate))
      end
    else
      @user.custom_roles.delete(Role.send(:user))
      @user.custom_roles.delete(Role.send(:admin))
      @user.custom_roles.delete(Role.send(:associate))
    end
    redirect_to @user
  end

  # Public: /users/:id/show Show user details
  #
  # Params: user id 
  #
  # Render show action
  def show
    @user = @user || User.where(id: params[:id]).first
  end

  # Private: user_params - permit parameters
  #
  # Returns nothing
  private
    def user_params
      params.require(:user).permit(:username, :email, :avatar)
    end
end
