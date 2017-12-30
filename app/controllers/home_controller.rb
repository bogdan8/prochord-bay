class HomeController < ApplicationController
  def index; end

  def search
    search = Song.search do
      fulltext params[:term].downcase
      with :active, 1
      order_by :created_at, :desc
      paginate page: params[:page], per_page: 10
    end

    render json: search.results.pluck(:title)
  end
end
