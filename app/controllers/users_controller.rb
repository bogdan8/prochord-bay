class UsersController < ApplicationController
  load_and_authorize_resource class: User

  before_action :delete_user_role, only: [:do_admin, :do_user]

  def index
    @users = User.all.page(params[:page]).per(30)
  end

  def do_admin
    @user.add_role(:admin)
    redirect_to users_all_path, flash: { success: 'Змінено на адміна' }
  end

  def do_user
    @user.add_role(:user)
    redirect_to users_all_path, flash: { success: 'Змінено на користувача' }
  end

  def delete_user_role
    @user.roles.delete_all
  end
end
