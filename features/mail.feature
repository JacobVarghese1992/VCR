Feature: User in the mailbox page

As a user,
I want to access my mail successfully
So that I can view unread,read,deleted and sent mail


	Scenario: Access Inbox 
		Given I have logged in
		And I'm on the mailbox page
		When I click the inbox button 
		Then I should be able to view my Inbox

	Scenario: Access Sent 
		Given I have logged in
		And I'm on the mailbox page
		When I click the sent button 
		Then I should be able to view my Sent

	Scenario: Access Trash 
		Given I have logged in
		And I'm on the mailbox page
		When I click the trash button 
		Then I should be able to view my Trash



