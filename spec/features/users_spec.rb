require 'rails_helper'

feature 'Users' do
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
    login_user_feature userCreated
  end

  scenario '#edit' do
    login_user_feature userCreated
    visit edit_user_registration_path
    within '#edit_user' do
      fill_in 'user_name', with: 'new name'
      fill_in 'user_current_password', with: userCreated.password
    end
    click_button I18n.t('views.devise.password_edit_button')
    expect(page).to have_content I18n.t('devise.registrations.updated')
  end
end
