require "#{Rails.root}/app/controllers/push_notifications"

class ContactsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_customer, only: [:create_appointment]
  skip_before_action :verify_authenticity_token
  require "opentok"

  def index
  	@contacts = current_user.contacts
  	@contacts_physicians = current_user.contacts.where(role: 'doctor')
    @contacts_patients = current_user.contacts.where(role: 'patient')
  	me = Array.new
  	me << current_user
  	# Remove current user and pass the remaining users
  	
    @users_physicians = User.where(role: 'doctor') - me - @contacts
    @users_patients = User.where(role: 'patient') - me - @contacts

    @all_users = []
  respond_to do |format|
    format.html
    format.json { render json: @contacts }
  end
    

  end

  def show
	redirect_to(:action => "index")
  end

  def delete
   	# Delete and Destroy a contact
    user = User.find(params[:id])

    current_user.remove_contact(user)
    user.remove_contact(current_user)
    flash[:alert] = "#{user.first_name} #{user.last_name} has been removed from your contacts" 
  	redirect_to(:action => "index", :frag => "2a")	
  end

  def destroy
  	redirect_to(:action => "index")
  end	

  # Being reused for add - to be changed later
  def edit
 	  user = User.find(params[:id])
 	  current_user.add_contact(user)
    user.add_contact(current_user)
    flash[:notice] = "Your contacts have been updated" 	
 	  redirect_to(:action => "index")
  end	

  def create_session
    # Create a new session if dialed via the contact page
    opentok = OpenTok::OpenTok.new(API_OPENTOK[:key], API_OPENTOK[:secret])
    # Create a session id
    session_id = opentok.create_session.session_id
    # Update session id to the current user database
    current_user.session_id = session_id
    current_user.save
    contact = User.find(params[:id])
    # Update session id to the contacts database
    contact.session_id = session_id
    contact.save
    
    notification = PushNotification.new("Incoming call", "#{current_user.first_name} #{current_user.last_name} is calling you", webcast_url, contact.id)
    notification.push()

    redirect_to(:action => "webcast")
  end  

  def mail_session

    @recp=User.find(params[:id])
    redirect_to conv_session_path(:recp => @recp)
  end

  def webcast
    
    opentok = OpenTok::OpenTok.new(API_OPENTOK[:key], API_OPENTOK[:secret])
    @session_id = current_user.session_id
    if (@session_id.empty?)
      redirect_to(:action => "index")   
    else
      @token = opentok.generate_token(@session_id)
    end  
    
  end  

  def create_appointment
    @appointment = Appointment.new
    @receiver = User.find(params[:id])
    respond_to do |format|

      if @appointment.create_appointment(params, current_user)
        if !@appointment.new_record?
          notification = PushNotification.new("Appointment", "Dr. #{current_user.first_name} #{current_user.last_name} has scheduled an appointment with you", appointments_url, @receiver.id)
          notification.push()

          UserMailer.new_appointment(current_user,@receiver).deliver
          flash[:notice] = "Appointment scheduled with #{@receiver.first_name} #{@receiver.last_name} for #{params[:appointment][:datetime]}"
          redirect_to(:action => "index")  
        end  
        
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @appointment.errors.full_messages,
                                   status: :unprocessable_entity }
      end
    end
  end  

  def get_customer
    user = User.find(params[:id])
    @contacts = user.contacts
    respond_to do |format|
      format.html
      format.json { render json: @contacts }
    end
  
  end

  def set_customer
    puts "================================"
    puts "================================"
  
    user = User.find(params[:id])
    @contacts = user.contacts
    respond_to do |format|
      format.html
      format.json { render json: @contacts }
    end

  end

private 
  


  
  def contact_params
    params.require(:contact).permit(:first_name, :last_name)
  end

end



