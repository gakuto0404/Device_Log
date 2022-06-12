class Public::HomesController < ApplicationController

  def top
    @genres = Genre.all
    #@reviews = Review.all
    @search_params = review_search_params
    @reviews = Review.search(@search_params).includes(:genre)
  end
  private

  def review_search_params
    params.fetch(:search, {}).permit(:item_name, {:genre_ids => []})
  end
end