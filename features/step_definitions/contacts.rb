And(/^I'm on the contacts page$/) do
	click_link "Contacts"
end

Given(/^I click on all Physicians$/) do
	click_link "All Physicians"
end

When(/^I add the user$/) do
  find(:xpath, "//tr[td[contains(.,'User2')]]/td/a", :text => '').click
end

Then(/^my contact list should be updated$/) do
  assert page.has_content?("Your contacts have been updated")
end

When(/^I click the delete contact button$/) do
	find(:xpath, "//tr[td[contains(.,'User2')]]/td/a", :text => 'delete').click	
end

Then(/^the contact should be removed from my contact list$/) do
  assert page.has_content?("has been removed from your contacts")
end

When(/^I click the make a call button$/) do
  find(:xpath, "//tr[td[contains(.,'User2')]]/td/a", :text => 'call').click
end

When(/^I click the message button$/) do
  find(:xpath, "//tr[td[contains(.,'User2')]]/td/a", :text => 'message').click
end
		
Then(/^A web chat should be initiated$/) do
  assert page.find("#publisher")
end
Then(/^the compose page should open$/) do
  assert page.has_content?("Compose")
end
Then(/^End call$/) do
  page.find("#end_call").click
end

When(/^I can schedule an appointment$/) do
# As cucumber does not support JS Pop Ups backend unit tests were performed
	@apt = Appointment.new
	@parameters = Hash.new
	@appointment = Hash.new
	@appointment = {:price => 40 , :datetime => "2016-11-22 19:25:15"}
	@parameters = {:id => 2, :appointment => @appointment}
	@initiator = User.find(1)
	@apt.create_appointment(@parameters,@initiator)
	@apt.save
end	

Then(/^I should be able to make a paymet as the other user$/) do
# As cucumber does not support JS Pop Ups backend unit tests were performed
	@apt = Appointment.find(1)
	@pays = Hash.new
	@pays = { :card_number => "4929642537248212", :card_verification => "123", :card_expires_on => "11-2021", :first_name => "Jacob", :last_name => "Varghese"}
	@pays_params = Hash.new
	@pays_params = {:payment => @pays}
end

