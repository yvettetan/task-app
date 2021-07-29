require 'rails_helper'

RSpec.describe 'Creating Categories', driver: :selenium_chrome, js: true do
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

  it 'is invalid without a title' do
    visit '/categories/new'
    fill_in 'Title', with: ''
    click_on 'Create Category'
    expect(page).to have_content("Title can't be blank")
  end

  it 'is invalid without a description' do
    visit '/categories/new'
    fill_in 'Description', with: ''
    click_on 'Create Category'
    expect(page).to have_content("Description can't be blank")
  end
end
