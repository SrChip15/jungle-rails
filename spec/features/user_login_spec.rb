require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do
  # SETUP
  before :each do
    @user = User.create!(
      name: "ABC",
      email: "abc@123.com",
      password: "1234",
      password_confirmation: "1234"
    )
  end

  scenario "user can log in using valid credentials" do
    # ACT
    visit root_path
    find('body').click_link('Login')
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_button("Submit")
    sleep 5

    # DEBUG / VERIFY
    save_screenshot

    # VERIFY
    expect(page).to have_content('Signed in')
  end

end
