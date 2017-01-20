Feature: Contacts of a user

As a user,
I want to be able to manage contacts
So that I can message and call them


	Scenario: Add contact 
		Given I have logged in
		And Another user exists
		And I'm on the contacts page
		And I click on all Physicians
		When I add the user 		
		Then my contact list should be updated

	Scenario: Remove contact 
		Given I have logged in
		And Another user exists
		And I'm on the contacts page
		And I click on all Physicians
		And I add the user		
		When I click the delete contact button
		Then the contact should be removed from my contact list

	Scenario: Make a call 
		Given I have logged in
		And Another user exists
		And I'm on the contacts page
		And I click on all Physicians
		And I add the user		
		When I click the make a call button
		Then A web chat should be initiated	
		Then End call	

	Scenario: Message a contact
		Given I have logged in
		And Another user exists
		And I'm on the contacts page
		And I click on all Physicians
		And I add the user
		When I click the message button
		Then the compose page should open