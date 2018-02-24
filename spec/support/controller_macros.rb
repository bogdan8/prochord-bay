def login_admin
  before(:each) do
    user = create(:user)
    user.add_role :admin
    sign_in user
  end
end

def login_user
  before(:each) do
    user = create(:user)
    user.add_role :user
    sign_in user
  end
end

def login_user_feature(user)
  visit new_user_session_path
  within '#new_user' do
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
  end
  click_button I18n.t('views.pages.sign_in')
  expect(page).to have_content I18n.t('devise.sessions.signed_in')
end
