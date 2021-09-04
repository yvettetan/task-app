require "rails_helper"

RSpec.describe "Creating User", driver: :selenium_chrome, js: true do
  describe "Creating valid User" do
    it "successfully creates a new user with email, password" do
      visit new_user_registration_path
      within "form" do
        fill_in "Email", with: "testt@gmail.com"
        fill_in "Password", with: "paul091725"
        fill_in "Password confirmation", with: "paul091725"
        click_on "Sign up"
      end
      expect(page).to have_content("Welcome! You have signed up successfully.")
    end
  end

  describe "Creating an invalid User" do
    it "is invalid email already taken" do
      user = FactoryBot.create(:user)
      login_as(user)
      logout
      visit new_user_registration_path
      fill_in "Email", with: user.email
      fill_in "Password", with: "paul091725"
      fill_in "Password confirmation", with: "paul091725"
      click_on "Sign up"
      expect(page).to have_text("Email has already been taken")
    end

    it "is invalid password" do
      visit new_user_registration_path
      fill_in "Email", with: "ey@gmail.com"
      fill_in "Password", with: "paul091725"
      fill_in "Password confirmation", with: "paul0917256"
      click_on "Sign up"
      expect(page).to have_text("Password confirmation doesn't match Password")
    end

    it "is invalid without email and passwords" do
      visit new_user_registration_path
      fill_in "Email", with: ""
      fill_in "Password", with: ""
      fill_in "Password confirmation", with: ""
      click_on "Sign up"
      expect(page).to have_text("Email can't be blank")
      expect(page).to have_text("Password can't be blank")
    end
  end
end
