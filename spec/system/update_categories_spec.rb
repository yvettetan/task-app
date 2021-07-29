require 'rails_helper'

RSpec.describe 'Updating Categories', type: :system, driver: :selenium_chrome, js: true do
  it 'edits and updates a category' do
    category = Category.create!(title: 'Home', description: 'daily tasks at home')
    # visit all categories route
    visit categories_path
    # expect page to have link to edit category
    expect(page).to have_link 'Edit'
    # visit show category route
    visit category_path(id: category.id)
    # expect page to have link to edit category
    expect(page).to have_link 'Edit'
    # visit edit category route
    visit edit_category_path(id: category.id)
    # fill in the form with needed information
    fill_in 'Title', with: 'School Assignments'
    fill_in 'Description', with: 'daily assignments for school'
    # click a submit button
    click_on 'Update Category'
    # expect the page to have the content we submitted
    expect(page).to have_content('School Assignments')
    expect(page).to have_content('daily assignments for school')
    expect(page).to have_text('Category was successfully updated')
    # ensure category is updated in database
    updated_category = Category.find(category.id)
    expect(updated_category.title).to eq('School Assignments')
    expect(updated_category.description).to eq('daily assignments for school')
    sleep(10)
  end
end
