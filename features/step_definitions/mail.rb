Given(/^I have logged in$/) do
  User.create(email: "username@example.com", password: "testtesttest", first_name: "User", last_name: "user", phone_one: "111111111", role: "doctor")
  visit(new_user_registration_path)
  fill_in 'login_email', :with => "username@example.com"
  fill_in 'login_password', :with => "testtesttest"
  click_button "Login"

end

Given(/^I'm on the mailbox page$/) do
	click_link "Messages"
end

When (/^I click the inbox button$/) do
	first(:link, "Inbox").click
	
end

And (/^Another user exists/) do 
	User.create(email: "user@example.com", password: "testtesttest", first_name: "User2", last_name: "user2", phone_one: "111111111")
end	


Then (/^I should be able to view my Inbox$/) do 
	assert page.has_css?("li.active a span#Inbox")
end

When (/^I click the sent button$/) do
	# click_link "Sent"
	first(:link, "Sent").click
end


Then (/^I should be able to view my Sent$/) do 
	assert page.has_css?("li.active a span#Sent")
end

When (/^I click the trash button$/) do
	# click_link "Trash"
	first(:link, "Trash").click
end


Then (/^I should be able to view my Trash$/) do 
	assert page.has_css?("li.active a span#Trash")
end

When (/^I click the compose button$/) do 
	
	 first(:link, "Compose").click

end

Then (/^I should be able to view the compose page$/) do
	assert page.has_content?("Recipients")
	assert page.has_content?("Subject")
	assert page.has_content?("Message")
end

When (/^I write a mail$/) do
    select "User2", :from => "recipients"
	fill_in 'subject',:with => "User2 user2"
	fill_in 'message',:with => "User2 user2"
end

When (/^I click send$/) do
	click_button "Send Message"
end

Then (/^the mail should be sent successfully$/) do
	assert page.has_content?("Your message was successfully sent!")
end 

#Then (/^ I should be asked to fill in recipients$/) do
#	assert page.has_content?("Please select an item in the list")
#end
