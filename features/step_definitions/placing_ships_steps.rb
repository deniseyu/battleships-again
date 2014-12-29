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

When(/^I enter a starting coordinate$/) do
  fill_in 'coordinate', :with => 'A3'
end

When(/^I forget to choose an orientation$/) do
  click_button 'Go!'
end

Then(/^I should see the message 'All fields need to be filled out!'$/) do
  expect(page).to have_content 'All fields need to be filled out!'
end

When(/^I enter an orientation$/) do
  choose 'vertical'
end

When(/^I forget to choose a coordinate$/) do
  click_button 'Go!'
end


When(/^I place my Battleship$/) do
  click_link 'Battleship'
  choose 'vertical'
  fill_in 'coordinate', :with => 'A1'
  click_button 'Go!'
end

When(/^I place my Patrolboat$/) do
  visit '/place_ships'
  click_link 'Patrolboat'
  choose 'horizontal'
  fill_in 'coordinate', :with => 'A3'
  click_button 'Go!'
end

When(/^I place my Destroyer$/) do
  visit '/place_ships'
  click_link 'Destroyer'
  choose 'horizontal'
  fill_in 'coordinate', :with => 'B4'
  click_button 'Go!'
end

When(/^I place my Submarine$/) do
  visit '/place_ships'
  click_link 'Submarine'
  choose 'horizontal'
  fill_in 'coordinate', :with => 'G5'
  click_button 'Go!'
end

When(/^lastly I place my Dreadnought$/) do
  visit '/place_ships'
  click_link 'Dreadnought'
  choose 'horizontal'
  fill_in 'coordinate', :with => 'H4'
  click_button 'Go!'
end

Then(/^I should see a link to begin the game$/) do
  expect(page).to have_content 'All ships placed, ready to begin!'
end
