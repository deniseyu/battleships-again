Given(/^I am on the homepage$/) do
  visit '/'
end

When(/^I click 'New Game'$/) do
  click_link 'New Game'
end

Then(/^I should see the question 'What is your name\?'$/) do
  expect(page).to have_content 'What is your name?'
end

Given(/^I am registered$/) do
  visit '/'
  click_link 'New Game'
  fill_in 'name', :with => 'Denise'
  click_button 'Submit'
end

When(/^I am at my command center$/) do
  click_link 'Click here to begin!'
  expect(page).to have_content "Denise's Command Center"
end

Then(/^I should see two boards \- the firing board and my board$/) do
  expect(page).to have_selector '.cell', :count => 100
end
