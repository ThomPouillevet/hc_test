class RequestsController < ApplicationController

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      @request.set_confirmation_token
      @request.save(validate: false)
      RequestMailer.registration_confirmation(@request).deliver_now
      flash[:success] = "Please confirm your email address to be register in our waiting list"
      redirect_to request_path(@request)
    else
      flash[:error] = "Invalid, please try again"
      render :new
    end
  end

  def show
    @request = Request.find(params[:id])
  end

  def confirm_email
    request = Request.find_by_confirm_token(params[:token])
    if request
      request.validate_email
      request.save(validate: false)
      redirect_to request
    else
      flash[:error] = "Sorry. request does not exist"
      redirect_to root_url
    end
  end


  private

  def request_params
    params.require(:request).permit(:name, :email, :phone, :biography, :state)
  end

end