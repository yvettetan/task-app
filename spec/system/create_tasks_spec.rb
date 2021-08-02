require 'rails_helper'

RSpec.describe 'Creating Categories', driver: :selenium_chrome, js: true do
  before :each do
    @category = Category.create!(title: 'Title', description: 'description')
  end
  describe 'Viewing all Tasks' do
    it 'shows all tasks under a category' do
      visit category_path(@category.id)
      within 'body' do
        expect(page).to have_content(@category.title)
        expect(page).to have_content(@category.description)
        expect(page).to have_link('New Task')
      end
    end
  end
  describe 'Creating a valid Task' do
    it 'successfully creates a new task with name and description' do
      visit category_path(id: @category.id)
      click_on 'New Category'
      within 'form' do
        fill_in 'Name', with: 'Name'
        fill_in 'Description', with: 'Description'
        click_on 'Create Task'
      end
      expect(page).to have_current_path category_path(@category.id)
      expect(page).to have_content('Name')
      expect(page).to have_content('Description')
      expect(page).to have_text('Task was successfully created')
      task = Task.order('id').last
      expect(task.title).to eq('Name')
      expect(category.description).to eq('Description')
    end
    it 'is valid without a description' do
      visit "categories/#{@category.id}/tasks/new"
      within 'form' do
        fill_in 'Name', with: 'Name'
        fill_in 'Description', with: ''
        click_on 'Create Task'
      end
      expect(page).to have_text('Task was successfully created')
    end
  end

  describe 'Creating an invalid Task' do
    it 'is invalid without a name' do
      visit "categories/#{@category.id}/tasks/new"
      within 'form' do
        fill_in 'Name', with: ''
        fill_in 'Description', with: 'Description'
        click_on 'Create Task'
      end
      expect(page).to have_text("Name can't be blank")
    end
  end
end
