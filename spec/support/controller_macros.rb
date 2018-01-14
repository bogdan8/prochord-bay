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
