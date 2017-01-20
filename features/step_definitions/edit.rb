Given(/^I'm on the edit page$/) do
	click_link "Profile"
end

When(/^I fill in the new name and submit$/) do
  fill_in 'First Name', :with => "TEST"
  fill_in 'Last Name', :with => "TEST"
  fill_in 'Current Password', :with => "testtesttest"
  click_button "Update"
end

Then (/^the account should be updated$/) do
	assert page.has_content?("Your account has been updated successfully")
end

When(/^I fill in the new name without password and submit$/) do
  fill_in 'First Name', :with => "TEST"
  fill_in 'Last Name', :with => "TEST"
  click_button "Update"
end

Then (/^the account should not be updated$/) do
	assert_not page.has_content?("Your account has been updated successfully")
end