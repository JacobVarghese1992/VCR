Feature: User Sign up page
  
As a user,
I want to create an account successfully
So that I can access the application
  
	Scenario: Add an user with valid data
		Given I'm on the user Sign up page
		When I add a new user
		Then I should be able to see the userpage with user signing in

	Scenario: Add an user without Email
		Given I'm on the user Sign up page
		When I add a new user without username
		Then I can't create an user without username
		
	Scenario: Add an user with same Email
		Given I have set up the user database
		And I'm in the user sign in page
		When I add a new user with same Email
		Then I can't create an user with same Email

	Scenario: Add an user without password
		Given I'm on the user Sign up page
		When I add a new user without password
		Then I can't create an user without password
		
	Scenario: Add an user with short password
		Given I'm on the user Sign up page
		When I add a new user with short password
		Then I can't create an user with short password