require 'rails_helper'

RSpec.describe 'Deleting Tasks', type: :system, driver: :selenium_chrome, js: true do
  describe 'Deleting a category' do
    it 'successfully deletes a task' do
      category = Category.new(title: 'Category Title', description: 'category description')
      task = category.tasks.build(name: 'task', description: 'description of task', due_at: Date.today.to_s,
                                  category_id: category.id)
      category.save
      visit category_task_path(category, task)
      expect(page).to have_link 'Delete'
      visit category_path(id: category.id)
      click_on 'Delete'
      expect(page.driver.browser.switch_to.alert.text).to eq "Are you sure you want to delete #{task.name}?"
      expect(page.driver.browser.switch_to.alert.accept).to change(category.tasks, :count).by(-1)
      expect { task.reload }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
