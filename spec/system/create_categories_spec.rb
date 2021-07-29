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
    # expect the page to have a successful creation message
    expect(page).to have_text('Category was successfully created')
    # ensure category is saved to database
    category = Category.order('id').last
    expect(category.title).to eq('title')
    expect(category.description).to eq('description')
    sleep(10)
  end

  it 'is invalid without a title' do
    visit '/categories/new'
    fill_in 'Title', with: ''
    click_on 'Create Category'
    expect(page).to have_text("Title can't be blank")
  end

  it 'is invalid without a description' do
    visit '/categories/new'
    fill_in 'Description', with: ''
    click_on 'Create Category'
    expect(page).to have_text("Description can't be blank")
  end
end
