require 'rails_helper'

def sign_in(user)
  visit new_user_session_path
  within '#new_user' do
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
  end
  click_button I18n.t('views.pages.sign_in')
  expect(page).to have_content I18n.t('devise.sessions.signed_in')
end

feature 'User' do
  let(:user) { build(:user) }
  scenario '#sign up' do
    visit new_user_registration_path
    within '#new_user' do
      fill_in 'user_name', with: user.name
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password
    end
    click_button I18n.t('views.devise.registration_button')
    expect(page).to have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
  end

  let(:userCreated) { create(:user) }
  scenario '#sign in' do
    sign_in userCreated
  end

  scenario '#edit' do
    sign_in userCreated
    visit edit_user_registration_path
    within '#edit_user' do
      fill_in 'user_name', with: 'new name'
      fill_in 'user_current_password', with: userCreated.password
    end
    click_button I18n.t('views.devise.password_edit_button')
    expect(page).to have_content I18n.t('devise.registrations.updated')
  end
end
