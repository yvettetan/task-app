require 'rails_helper'

RSpec.describe 'Updating Categories', type: :system, driver: :selenium_chrome, js: true do
  describe 'Updating a category' do
    it 'successfully updates a category' do
      user = FactoryBot.create(:user)
      login_as(user)
      category = Category.create!(title: 'Home', description: 'daily tasks at home', user_id: user.id)
      visit category_path(category.id)
      click_link 'Edit Category'
      within 'form' do
        fill_in 'Title', with: 'School Assignments'
        fill_in 'Description', with: 'Daily assignments for school'
        click_on 'Update Category'
      end
      expect(page).to have_current_path category_path(id: category.id)
      expect(page).to have_content(/School Assignments/i)
      expect(page).to have_content(/Daily assignments for school/i)
      expect(page).to have_text('Category was successfully updated')
      updated_category = Category.find(category.id)
      expect(updated_category.title).to eq('School Assignments')
      expect(updated_category.description).to eq('Daily assignments for school')
    end
  end
end
