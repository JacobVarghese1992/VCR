Feature: User in the mailbox page

As a user,
I want to be able to access mail compostition
So that I can write and send mail


	Scenario: Access Conversation 
		Given I have logged in
		And I'm on the mailbox page
		When I click the compose button 
		Then I should be able to view the compose page

	Scenario: Send mail 
		Given I have logged in
		And Another user exists
		And I'm on the mailbox page
		And I click the compose button
		When I write a mail 		
		And I click send
		Then the mail should be sent successfully

	
