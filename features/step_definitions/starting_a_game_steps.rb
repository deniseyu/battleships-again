Given(/^I am on the homepage$/) do
  visit '/'
end

When(/^I click 'New Game'$/) do
  click_link 'New Game'
end

Then(/^I should see the question 'What is your name\?'$/) do
  expect(page).to have_content 'What is your name?'
end
