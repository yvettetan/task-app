require 'rails_helper'

RSpec.describe 'CreateCategories', driver: :selenium_chrome, js: true do
  it 'creates and displays a category' do
    # visit new category route
    visit '/categories/new'
    # fill in the form with needed information
    fill_in 'Title', with: 'title'
    fill_in 'Description', with: 'description'
    # click a submit button
    click_on 'Create Category'
    # expect the page to have the content we submitted
    expect(page).to have_content('title')
    expect(page).to have_content('description')
  end
end
