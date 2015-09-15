class EmailsController < ApplicationController
  def index
    redirect_to new_email_path
  end

  def new
    @email = Email.new
  end

  def create
    @email = Email.new(params[:email])
    if @email.valid?
      ActionMailer::Base.mail(@email.to_h).deliver_now
      redirect_to new_email_path
    else
      render 'new'
    end
  end
end
