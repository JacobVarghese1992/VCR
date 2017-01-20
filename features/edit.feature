Feature: User in the edit prfile page

As a user,
I want to edit my profile successfully
So that I can update my profile


	Scenario: successful update
		Given I have logged in
		And I'm on the edit page
		When I fill in the new name and submit
		Then the account should be updated

	Scenario: update without password
		Given I have logged in
		And I'm on the edit page
		When I fill in the new name without password and submit
		Then the account should not be updated
