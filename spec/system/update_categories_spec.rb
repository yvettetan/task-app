require 'rails_helper'

RSpec.describe 'Updating Categories', type: :system, driver: :selenium_chrome, js: true do
  describe 'Updating a category' do
    before { visit categories_path }
    it 'successfully updates a category' do
      category = Category.create!(title: 'Home', description: 'daily tasks at home')
      visit categories_path
      expect(page).to have_link 'Edit'
      visit category_path(id: category.id)
      click_on 'Edit'
      within 'form' do
        fill_in 'Title', with: 'School Assignments'
        fill_in 'Description', with: 'daily assignments for school'
        sleep(3)
        click_on 'Update Category'
      end
      expect(page).to have_current_path category_path(id: category.id)
      expect(page).to have_content('School Assignments')
      expect(page).to have_content('daily assignments for school')
      expect(page).to have_text('Category was successfully updated')
      sleep(3)

      updated_category = Category.find(category.id)
      expect(updated_category.title).to eq('School Assignments')
      expect(updated_category.description).to eq('daily assignments for school')
    end
  end
end
