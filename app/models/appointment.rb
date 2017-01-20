class Appointment < ApplicationRecord
  require 'date'
  require "active_merchant/billing/rails"

  belongs_to :initiator, class_name: "User"
	belongs_to :receiver,   class_name: "User"
	validates :initiator_id, presence: true
  validates :receiver_id, presence: true

  has_one :payment

  def create_appointment(parameters, initiator)	
    if (parameters[:appointment])
      self.update(:initiator_id => initiator.id, :receiver_id => parameters[:id], :price => parameters[:appointment][:price], :currency => "USD", :datetime => DateTime.parse(parameters[:appointment][:datetime]))
    end	


    return true
  end	


  def validate_and_pay(payment_params, payment, ip_address)
    if (payment_params[:payment])
      # payment = Payment.new(payment_parameters(payment_params))
      payment = Payment.new(payment_params[:payment])
      payment.ip_address = ip_address
      payment.appointment_id = self.id
      create_card(payment_params[:payment])
      if @credit_card.valid?
        response = GATEWAY.purchase(price*100, @credit_card, :ip => payment.ip_address)
        if (response.success?)
          payment.save
          attributes[:paid] = true
          self.update_attributes(attributes)
          return "true"                  
        else
          return "Error processing the payment. #{response.message}"          
        end  
      else
        return "Error: credit card is not valid. #{@credit_card.errors.full_messages.join('. ')}"
      end
    end
    return "true"
  end

  private

  def create_card(params)

    @credit_card = ActiveMerchant::Billing::CreditCard.new(
    :brand               => CreditCardValidations::Detector.new(params[:card_number]).brand,
    :number             => params[:card_number],
    :verification_value => params[:card_verification],
    :month              => params[:card_expires_on].split("-")[0],
    :year               => params[:card_expires_on].split("-")[1],
    :first_name         => params[:first_name],
    :last_name          => params[:last_name]
    )

  end 

  def payment_parameters(payment_params)
    payment_params.require(:payment).permit( :first_name, :last_name, :card_expires_on)
  end 

end
