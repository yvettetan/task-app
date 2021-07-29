require 'rails_helper'

RSpec.describe 'Updating Categories', type: :system, driver: :selenium_chrome, js: true do
  it 'edits and updates a category' do
    category = Category.create!(title: 'title', description: 'description')
    # visit edit category route
    visit edit_category_path(id: category.id)
    # fill in the form with needed information
    fill_in 'Title', with: 'title'
    fill_in 'Description', with: 'description'
    # click a submit button
    click_on 'Update Category'
    # expect the page to have the content we submitted
    expect(page).to have_content('title')
    expect(page).to have_content('description')
    expect(page).to have_text('Category was successfully updated')
  end
end
