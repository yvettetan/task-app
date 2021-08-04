require 'rails_helper'

RSpec.describe 'Creating Tasks', type: :system, driver: :selenium_chrome, js: true do
  before :each do
    @category = Category.create!(title: 'Title', description: 'description')
  end
  describe 'Creating a valid Task' do
    it 'successfully creates a new task with name, description and due date' do
      visit category_path(@category.id)
      click_on 'Create Task'
      fill_in 'Name', with: 'Name'
      fill_in 'Description', with: 'Description'
      page.find('#task_due_at').click
      page.find('span', text: '30').click
      click_on 'Create Task'
      expect(page).to have_current_path category_path(@category.id)
      expect(page).to have_content('Name')
      expect(page).to have_content('Description')
      expect(page).to have_content(Date.today.strftime('%b 30, %Y').to_s)
      task = Task.order('id').last
      expect(task.name).to eq('Name')
      expect(task.description).to eq('Description')
      expect(task.due_at).not_to be_nil
    end
  end

  describe 'Creating an invalid Task' do
    it 'is invalid without a name' do
      visit new_category_task_path(@category.id)
      fill_in 'Name', with: ''
      fill_in 'Description', with: 'Description'
      click_on 'Create Task'
      expect(page).to have_text("Name can't be blank")
    end
    it 'is invalid without a description' do
      visit new_category_task_path(@category.id)
      fill_in 'Name', with: 'Name'
      fill_in 'Description', with: ''
      click_on 'Create Task'
      expect(page).to have_text("Description can't be blank")
    end
    it 'is invalid without a date' do
      visit new_category_task_path(@category.id)
      fill_in 'Name', with: 'Name'
      fill_in 'Description', with: 'Description'
      click_on 'Create Task'
      expect(page).to have_text("Due at can't be blank")
    end
  end
end
