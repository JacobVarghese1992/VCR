Feature: Document Uploads

As a user,
I want to be able to create folders and upload documents
So that my patient/doctor can access and share them later


	Scenario: Create new folder 
		Given I have logged in
		And I'm on the Documents page
		And I click New Folder
		When I fill in the folder name and submit
		Then A new folder will get created


	Scenario: Upload a file 
		Given I have logged in
		And I'm on the Documents page
		And I click Upload to take me to the upload page
		When I attach and upload a file
		Then The file can be seen by the user

	Scenario: Delete a file 
		Given I have logged in
		And I'm on the Documents page
		And I click Upload to take me to the upload page
		And I attach and upload a file
		When I click Delete
		Then I will see a Successful delete message

	Scenario: Delete a folder 
		Given I have logged in
		And I'm on the Documents page
		And I click New Folder
		When I fill in the folder name and submit
		When I click Delete
		Then I will see a Successful delete message	

	Scenario: Download a file 
		Given I have logged in
		And I'm on the Documents page
		And I click Upload to take me to the upload page
		And I attach and upload a file
		Then I click Download	

	Scenario: Browse through a folder 
		Given I have logged in
		And I'm on the Documents page
		And I click New Folder
		And I fill in the folder name and submit
		When I click the folder name
		Then I should have navigated into the folder
