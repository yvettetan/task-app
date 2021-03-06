require 'rails_helper'

RSpec.describe 'Deleting Tasks', type: :system, driver: :selenium_chrome, js: true do
  describe 'Deleting a task' do
    it 'successfully deletes a task' do
      user = FactoryBot.create(:user)
      login_as(user)
      category = Category.new(title: 'Category Title', description: 'category description', user_id: user.id)
      task = category.tasks.build(name: 'task', description: 'description of task', due_at: Date.today.to_s,
                                  category_id: category.id, user_id: user.id)
      category.save
      visit category_task_path(category, task)
      page.find('a', class: 'fa-trash-alt').click
      expect(page.driver.browser.switch_to.alert.text).to eq("Are you sure you want to delete #{task.name}?")
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_current_path category_path(category.id)
      expect(page).to have_content('Task was successfully deleted')
    end
  end
end
