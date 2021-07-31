require 'rails_helper'

RSpec.describe 'Deleting Categories', type: :system, driver: :selenium_chrome, js: true do
  describe 'Deleting a category' do
    it 'successfully deletes a category' do
      category = Category.create!(title: 'Title', description: 'description')
      visit categories_path
      expect(page).to have_link 'Delete'
      visit category_path(id: category.id)
      click_on 'Delete'
      expect(page.driver.browser.switch_to.alert.text).to eq "Are you sure you want to delete #{category.title}?"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_text('Category was successfully deleted')
      expect { category.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
