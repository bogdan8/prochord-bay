module Admin
  class PerformersController < ApplicationController
    load_and_authorize_resource find_by: :slug

    def index
      search = Performer.search do
        order_by :created_at, :desc
        paginate page: params[:page], per_page: 30
      end
      @performers = search.results
    end

    def show; end

    def new; end

    def create
      @performer = Performer.new(performer_params)
      if @performer.save
        redirect_to @performer, success: t('controllers.performers.success_create')
      else
        flash[:error] = @performer.errors.full_messages.to_sentence
        render :new
      end
    end

    def edit; end

    def update
      if @performer.update(performer_params)
        redirect_to @performer, success: t('controllers.performers.success_update')
      else
        flash[:error] = @performer.errors.full_messages.to_sentence
        render :edit
      end
    end

    def destroy
      if @performer.destroy
        redirect_to performers_path, success: t('controllers.performers.success_delete')
      else
        flash[:error] = @performer.errors.full_messages.to_sentence
      end
    end

    private

    def performer_params
      params.require(:performer).permit(:title, :avatar)
    end
  end
end
