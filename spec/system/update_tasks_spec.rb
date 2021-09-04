require 'rails_helper'

RSpec.describe 'Updating Tasks', type: :system, driver: :selenium_chrome, js: true do
  describe 'Updating a task' do
    it 'successfully updates a task' do
      user = FactoryBot.create(:user)
      login_as(user)
      category = Category.new(title: 'Home', description: 'list of tasks at home', user_id: user.id)
      task = category.tasks.build(name: 'Laundry', description: 'sort, wash and dry clothes', due_at: Date.today.to_s,
                                  category_id: category.id, user_id: user.id)
      category.save
      visit category_task_path(category, task)
      page.find('a', class: 'fa-edit').click
      fill_in 'Name', with: 'Laundry'
      fill_in 'Description', with: 'Sort, wash, dry and fold clothes'
      page.find('#task_due_at').click
      page.find('span', text: '10').click
      click_on 'Update Task'
      expect(page).to have_current_path category_path(category.id)
      expect(page).to have_content('Laundry')
      expect(page).to have_content('Sort, wash, dry and fold clothes')
      expect(page).to have_content(Date.today.strftime('%b 10, %Y').to_s)
      updated_task = Task.find(task.id)
      expect(updated_task.name).to eq('Laundry')
      expect(updated_task.description).to eq('Sort, wash, dry and fold clothes')
      expect(task.due_at).not_to be_nil
    end
  end
end
