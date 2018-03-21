class HomeController < ApplicationController
  def index; end

  def search
    return head 400 unless params[:term]
    #search = Song.search do
    #  fulltext params[:term].downcase
    #  with :active, 1
    #  order_by :created_at, :desc
    #  paginate page: params[:page], per_page: 10
    #end
    render json: Song.all.pluck(:title), status: 200
  end
end
