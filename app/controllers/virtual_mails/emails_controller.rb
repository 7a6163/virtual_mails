class VirtualMails::EmailsController < VirtualMails::ApplicationController
  before_action :find_mail, :only => [:show, :raw]

  def index
    @emails = Email.all
  end

  def show
  end

  def raw
    render :plain => @email.raw
  end

  def clear
    Email.clear
    redirect_to emails_path
  end

  private

  def find_mail
    @email = Email.find(params[:id])
  end
end
