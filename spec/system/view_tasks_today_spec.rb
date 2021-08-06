require 'rails_helper'

RSpec.describe 'Viewing tasks for today', type: :system, driver: :selenium_chrome, js: true do
  before :each do
    login_as(FactoryBot.create(:user))
    @category = Category.create!(title: 'Title', description: 'description')
  end
  describe 'Viewing a task today' do
    it 'successfully creates a new task with name, description and due date' do
      visit category_path(@category.id)
      click_on 'Create Task'
      fill_in 'Name', with: 'Name'
      fill_in 'Description', with: 'Description'
      page.find('#task_due_at').click
      date = Date.today.strftime('%d')
      page.find('span', text: date.to_s).click
      click_on 'Create Task'
      visit tasks_path
      within('#today') { expect(page).to have_content('Name') }
      within('#today') { expect(page).to have_content('Description') }
    end
  end
end
