When(/^I visit the index page in a new browser window$/) do
  Capybara.session_name = 'player2'
  visit '/'
end

Then(/^I should see a link 'Join Game'$/) do
  expect(page).to have_link('Join Game')
end
