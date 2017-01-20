Given(/^I'm on the user Sign up page$/) do
  visit(new_user_registration_path)
end

When(/^I add a new user$/) do
  
	fill_in 'signup-email', :with => "username@example.com"
	fill_in 'signup-password', :with => "password"
	fill_in 'signup-password-confirm', :with => "password"
  fill_in 'Primary Phone number', :with => "11111111"
  fill_in 'First Name', :with => "First Name"
  fill_in 'Last Name', :with => "Last Name"
	click_button "Sign up"
	
end

Then(/^I should be able to see the userpage with user signing in$/) do
 assert page.has_content?("Welcome! You have signed up successfully.")
 assert page.has_link?( 'Log Out')
end
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
When(/^I add a new user without username$/) do
  fill_in 'signup-password', :with => "password"
  fill_in 'signup-password-confirm', :with => "password"
  fill_in 'Primary Phone number', :with => "11111111"
  fill_in 'Last Name', :with => "Last Name"
  click_button "Sign up"
end

Then(/^I can't create an user without username$/) do
  assert page.has_content?("Email can't be blank")
end

# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
Given(/^I have set up the user database$/) do
  User.create(email: "username@example.com", password: "testtesttest", first_name: "User", last_name: "user", phone_one: "111111111")
end

Given(/^I'm in the user sign in page$/) do
  visit(new_user_registration_path)
end

When(/^I add a new user with same Email$/) do
  	fill_in 'signup-email', :with => "username@example.com"
	fill_in 'signup-password', :with => "password"
	fill_in 'signup-password-confirm', :with => "password"
  fill_in 'Primary Phone number', :with => "11111111"
  fill_in 'Last Name', :with => "Last Name"
	click_button "Sign up"
end

Then(/^I can't create an user with same Email$/) do
  assert page.has_content?("Email has already been taken")
end

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
When(/^I add a new user without password$/) do
  fill_in 'signup-email', :with => "username@example.com"
  click_button "Sign up"
end

Then(/^I can't create an user without password$/) do
  assert page.has_content?("Password can't be blank")
end

#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------

When(/^I add a new user with short password$/) do
  fill_in 'signup-password', :with => "passw"
  fill_in 'signup-password-confirm', :with => "passw"
  fill_in 'Primary Phone number', :with => "11111111"
  click_button "Sign up"
end

Then(/^I can't create an user with short password$/) do
  assert page.has_content?("Password is too short (minimum is 6 characters)")
end

# Given (/^I have set up the user database$/) do
#   User.create(
#     Email: "Tom@seas.upenn.edu",
#     Password: "12345678",
#     Password_confirmation: "12345678")
# end

Given(/^I'm in the user log in page$/) do
  visit(new_user_registration_path)
end

When(/^I fill the credentials and log in$/) do
  fill_in 'login_email', :with => "username@example.com"
  fill_in 'login_password', :with => "testtesttest"
  click_button "Login"
end

Then(/^I should be able to log in successfully$/) do
  assert page.has_content?("Signed in successfully.")
end

When(/^I fill the wrong username or password$/) do
  fill_in 'login_email', :with => "T@seas.upenn.edu"
  fill_in 'login_password', :with => "1234567"
  click_button "Login"
end

Then(/^I should not be able to log in$/) do
  assert page.has_content?("Invalid Email or password.")
end


Given(/^I'm in the user launchpad$/) do
  visit root_path
end

When(/^click the log out$/) do
    click_link "Log Out"
end

Then(/^I should be able to sign out$/) do
  assert page.has_content?("Signed out successfully.")
  assert page.has_no_link? "Log Out"
end

When(/^I fill the wrong username and password and log in$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

# Given(/^I sign in with username and password$/) do
#   pending # Write code here that turns the phrase above into concrete actions
# end
