require 'rails_helper'

RSpec.describe 'Updating Tasks', type: :system, driver: :selenium_chrome, js: true do
  describe 'Updating a task' do
    it 'successfully updates a task' do
      category = Category.new(title: 'Home', description: 'list of tasks at home')
      task = category.tasks.build(name: 'Laundry', description: 'sort, wash and dry clothes', category_id: category.id)
      category.save
      visit category_task_path(category, task)
      click_on 'Edit'
      fill_in 'Name', with: 'Laundry'
      fill_in 'Description', with: 'sort, wash, dry and fold clothes'
      click_on 'Update Task'
      expect(page).to have_current_path category_path(category.id)
      expect(page).to have_content('Laundry')
      expect(page).to have_content('sort, wash, dry and fold clothes')
      updated_task = Task.find(task.id)
      expect(updated_task.name).to eq('Laundry')
      expect(updated_task.description).to eq('sort, wash, dry and fold clothes')
    end
  end
end
