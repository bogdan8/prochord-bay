module Users
  class UsersController < ApplicationController
    load_and_authorize_resource find_by: :slug

    def color
      current_user.update_attribute(:color, params[:color])
      redirect_to '/', success: t('controllers.songs.success_update')
    end
  end
end