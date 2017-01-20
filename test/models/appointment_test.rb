require 'test_helper'


class AppointmentTest < ActiveSupport::TestCase
  test "Create new appointment" do
    initiator = User.create(email: "username@example.com", password: "testtesttest", first_name: "User", last_name: "user", phone_one: "111111111")
    apt = Appointment.new
    parameters = Hash.new
    parameters[:appointment] = Hash.new
    parameters[:appointment][:price] = "50"
    parameters[:id] = 5
    parameters[:appointment][:datetime] = '2001-02-03T04:05:06+07:00'
    assert(apt.create_appointment(parameters,initiator))
  end


  test "validate_and_pay" do
    initiator = User.create(email: "username@example.com", password: "testtesttest", first_name: "User", last_name: "user", phone_one: "111111111")
    apt = Appointment.new
    parameters = Hash.new
    parameters[:appointment] = Hash.new
    parameters[:appointment][:price] = "50"
    parameters[:id] = 5
    parameters[:appointment][:datetime] = '2001-02-03T04:05:06+07:00'
    apt.create_appointment(parameters,initiator)
    payment_params = Hash.new
    payment_params[:payment]= Hash.new
    payment_params[:payment][:card_number] = '4430573008648709'
    payment_params[:payment][:card_verification] = '546'
    payment_params[:payment][:card_expires_on] = '08-2019'
    payment_params[:payment][:first_name] = 'Jacob'
    payment_params[:payment][:last_name] = 'Varghese'
    payment = []

    assert_equal apt.validate_and_pay(payment_params, payment, '127.0.0.1'), "true"

  end


  test "Errors" do
    initiator = User.create(email: "username@example.com", password: "testtesttest", first_name: "User", last_name: "user", phone_one: "111111111")
    apt = Appointment.new
    parameters = Hash.new
    parameters[:appointment] = Hash.new
    parameters[:appointment][:price] = "50"
    parameters[:id] = 5
    parameters[:appointment][:datetime] = '2001-02-03T04:05:06+07:00'
    apt.create_appointment(parameters,initiator)
    payment_params = Hash.new
    payment_params[:payment]= Hash.new
    payment_params[:payment][:card_number] = '4430573008648709'
    payment_params[:payment][:card_verification] = '546'
    payment_params[:payment][:card_expires_on] = '08-19'
    payment_params[:payment][:first_name] = 'Jacob'
    payment_params[:payment][:last_name] = 'Varghese'
    payment = []

    assert_includes apt.validate_and_pay(payment_params, payment, '127.0.0.1'), "Error"

  end

end
# 