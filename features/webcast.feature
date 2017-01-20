Feature: Video Conference

As a user,
I want to be able to make calls
So that I can have a video chat

	Scenario: Make a call 
		Given I have logged in
		And Another user exists
		And I'm on the contacts page
		And I click on all Physicians
		And I add the user		
		When I click the make a call button
		Then A web chat should be initiated	
		
	Scenario: Disconnect from a call 
		Given I have logged in
		And Another user exists
		And I'm on the contacts page
		And I click on all Physicians
		And I add the user		
		When I click the make a call button
		And  A web chat should be initiated
		When I click the end call button
		Then The call should have disconnected successfully			