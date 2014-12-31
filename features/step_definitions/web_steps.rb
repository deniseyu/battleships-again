Given(/^I am registered$/) do
  visit '/'
  click_link 'New Game'
  fill_in 'name', :with => 'Denise'
  click_button 'Submit'
end