require 'rails_helper'

RSpec.describe 'Creating Categories', type: :system, driver: :selenium_chrome, js: true do
  before :each do
    @category = Category.create!(title: 'Title', description: 'description')
  end
  describe 'Creating a valid Task' do
    it 'successfully creates a new task with name and description' do
      visit category_path(@category.id)
      click_on 'Create Task'
      fill_in 'Name', with: 'Name'
      fill_in 'Description', with: 'Description'
      click_on 'Create Task'
      expect(page).to have_current_path category_path(@category.id)
      expect(page).to have_content('Name')
      expect(page).to have_content('Description')
      task = Task.order('id').last
      expect(task.name).to eq('Name')
      expect(task.description).to eq('Description')
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
  end
end
