require "#{Rails.root}/app/controllers/push_notifications"
class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def new_wrecp

  end 
  def create
    recipients = User.where(id: conversation_params[:recipients])
    #Need to validate null subj and messages
    conversation = current_user.send_message(recipients, conversation_params[:body], conversation_params[:subject],nil,conversation_params[:attachment]).conversation
   
    flash[:success] = "Your message was successfully sent!"
    recipients.each do |contact|
      notification = PushNotification.new("New message", "You have a new message from #{current_user.first_name} #{current_user.last_name}", mailbox_inbox_url, contact.id)
      notification.push()
    end
    redirect_to conversation_path(conversation)
  end

  def show
    @receipts = conversation.receipts_for(current_user)
    # mark conversation as read
    conversation.mark_as_read(current_user)
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to mailbox_inbox_path
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to mailbox_inbox_path
  end
   def invite
      UserMailer.email(current_user.first_name+" "+current_user.last_name, params[:invitee],params[:email]).deliver
      

  end
  private

  def conversation_params
    params.require(:conversation).permit(:attachment,:subject,:body,recipients:[])
  end

 
end