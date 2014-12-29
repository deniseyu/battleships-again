Before do
  visit '/'
  click_link 'New Game'
  fill_in 'name', :with => 'Denise'
  click_button 'Submit'
  click_link 'Click here to begin!'
end

Given(/^I am on the place ships page$/) do
  visit '/place_ships'
end

When(/^I click 'Battleship'$/) do
  click_link 'Battleship'
end

When(/^I choose the orientation and starting coordinate$/) do
  choose 'vertical'
  fill_in 'coordinate', :with => 'C4'
  click_button 'Go!'
end

Then(/^I should see the message, "(.*?)"$/) do |arg1|
  expect(page).to have_content 'Battleship successfully placed!'
end

Then(/^see a corresponding number of cells on my board reflecting a ship$/) do
  expect(page).to have_selector '.water', :count => 96
  expect(page).to have_selector '#own-board-container .cell', :count => 4
end
