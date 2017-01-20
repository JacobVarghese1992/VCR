class UserMailer < ApplicationMailer
	include Rails.application.routes.url_helpers
    include ActionView::Helpers::UrlHelper
  default from: 'donotreply@medimailhub.us'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_appointment.subject
  #
  def new_appointment(current_user,receiver)
    @greeting = "Hi #{receiver.first_name} #{receiver.last_name}"
    @sender = "#{current_user.first_name} #{current_user.last_name}"
    mail to: receiver.email, subject: "New appointment requested by Dr.#{@sender}"
  end

  def appointment_confirmed(user1, user2)
  	@greeting = "Hi #{user1.first_name} #{user1.last_name}"
  	@user1 = user1
  	@user2 = user2

  	mail to: user1.email, subject: "Appointment with #{user2.first_name} #{user2.last_name} confirmed"

  end
  	
	def email(current_user, invitee, email)
		@user = current_user
	   	@url  = 'http://www.medimailhub.us'
	   	@invitee=invitee
	   	mail(to: email, subject: 'Join Medimail!') 	
	end
end
