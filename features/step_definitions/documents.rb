Given(/^I'm on the Documents page$/) do
	click_link "Documents"
end

When (/^I click Upload to take me to the upload page$/) do
	first(:link, "Upload").click
end

When (/^I click New Folder$/) do
	first(:link, "New Folder").click
end

When(/^I fill in the folder name and submit$/) do
  fill_in 'folder_name', :with => "new_folder"
  click_button "Create Folder"
end

Then(/^A new folder will get created$/) do
	assert page.has_content?("new_folder")
end	

When(/^I attach and upload a file$/) do
	attach_file('asset_uploaded_file', File.absolute_path('./public/bg.jpg'))
	click_button "Upload"
end

Then(/^The file can be seen by the user$/) do
	assert page.has_content?("bg.jpg")
end	

When(/^I click Delete$/) do
	first(:link, "Delete").click
end	

Then(/^I will see a Successful delete message$/) do
	assert page.has_content?("Successfully deleted")
end	

Then(/^I click Download$/) do
	first(:link, "Download").click
end

Then(/^I click the folder name$/) do
	first(:link, "new_folde").click
end


Then(/^I should have navigated into the folder$/) do
	assert page.has_content?("» new_folder")
end	

