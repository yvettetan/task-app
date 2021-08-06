require "rails_helper"

RSpec.describe "Login User", drive: :selenium_chrome, js: true do
  describe "Validate User" do
    it "successfully log in existing user" do
      visit new_user_session_path
      within "form" do
        fill_in "Email", with: "testt@gmail.com"
        fill_in "Password", with: "paul091725"
        click_on "Log in"
      end
      expect(page).to have_content("Signed in successfully.")
    end

    it "invalid user" do
      visit new_user_session_path
      within "form" do
        fill_in "Email", with: "yow@gmail.com"
        fill_in "Password", with: "12345"
        click_on "Log in"
      end
      expect(page).to have_content("Invalid Email or password.")
    end
  end
end
