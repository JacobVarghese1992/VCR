class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :mailbox, :conversation
  
  def reply
    current_user.reply_to_conversation(conversation, message_params[:body])
    flash[:notice] = "Your reply message was successfully sent!"
    redirect_to conversation_path(conversation)
  end
  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  
  def message_params
    params.require(:message).permit(:body, :subject,:attachment)
  end

  protected
  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    	user_params.permit( :email, :password, :password_confirmation, :first_name, :last_name, :phone_one, :phone_two, :d_o_b,:gender, :role, :remember_me)
    end
  	devise_parameter_sanitizer.permit(:sign_in) do |user_params|
    	user_params.permit( :email, :password, :remember_me)
  	end
  	#devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    #	user_params.permit( :email, :password, :password_confirmation, :first_name, :last_name, :phone_one, :phone_two, :d_o_b,:gender, :role,:remember_me)
  	#end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:current_password,:password,:password_confirmation,:specialization,:email,:first_name, :last_name, :phone_one, :phone_two, :d_o_b,:gender, :role)
    end

  end
  
end
