Feature: User in sign out
         
As a user,
I want to log out of my account successfully
So that I can access the sign up page


Scenario: User sign out
		Given I have set up the user database
		And I'm in the user log in page
		And I fill the credentials and log in
		When click the log out
		Then I should be able to sign out 