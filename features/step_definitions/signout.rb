#Given (/^I have set up the user database$/) do
# 	User.create(
# 		Email: "Tom@seas.upenn.edu",
# 		Password: "12345678",
# 		Password_confirmation: "12345678")
# end


# When(/^I fill the credentials and log in$/) do
#     fill_in 'Email', :with => "Tom@seas.upenn.edu"
# 	fill_in 'Password', :with => "12345678"
# 	click_button "Log in"
# end

# Given(/^I'm in the user launchpad$/) do
#   visit root_path
# end

# When(/^click the log out$/) do
#     click_link "Log out"
# end

# Then(/^I should be able to sign out$/) do
#   assert page.has_content?("Signed out successfully.")
#   assert page.has_no_link? "log Out"
# end