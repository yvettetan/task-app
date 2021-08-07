require 'rails_helper'

RSpec.describe 'Viewing tasks for today', type: :system, driver: :selenium_chrome, js: true do
  describe 'Viewing a task today' do
    it "successfully views today's tasks" do
      user = FactoryBot.create(:user)
      login_as(user)
      category = Category.new(title: 'Category Title', description: 'category description', user_id: user.id)
      task = category.tasks.build(name: 'task', description: 'description of task', due_at: Date.today.to_s,
                                  category_id: category.id, user_id: user.id)
      category.save
      visit tasks_path
      within('#today') { expect(page).to have_content(task.name) }
      within('#today') { expect(page).to have_content(task.description) }
    end
  end
end
