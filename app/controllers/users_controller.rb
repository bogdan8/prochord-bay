class UsersController < ApplicationController
  load_and_authorize_resource class: User

  def index
    @users = User.all.page(params[:page]).per(30)
  end

  def do_admin
    @user.roles.delete_all
    @user.add_role(:admin)
    redirect_to users_all_path, flash: { success: 'Змінено на адміна' }
  end

  def do_user
    @user.roles.delete_all
    @user.add_role(:user)
    redirect_to users_all_path, flash: { success: 'Змінено на користувача' }
  end
end
