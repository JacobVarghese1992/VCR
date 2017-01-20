Feature:Appointments and payments

As a user,
I want to be able set up appointments
So that pay for them

	Scenario: Create an appointment
		Given I have logged in
		And Another user exists
		And I'm on the contacts page
		And I click on all Physicians
		When I add the user
		Then I can schedule an appointment	

	Scenario: Make a payment
		Given I have logged in
		And Another user exists
		And I'm on the contacts page
		And I click on all Physicians
		When I add the user
		And I can schedule an appointment
		Then I should be able to make a paymet as the other user 			
