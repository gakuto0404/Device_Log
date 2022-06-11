class Public::HomesController < ApplicationController

  def top
    @genres = Genre.all
    @reviews = Review.all
  end
end
