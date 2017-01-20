Then(/^I click the end call button$/) do
  page.find("#end_call").click
end

Then(/^The call should have disconnected successfully$/) do
  assert page.has_content?("Your call has been disconnected")
end


