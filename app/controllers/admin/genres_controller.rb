class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    @genres = Genre.all
    if @genre.save
      redirect_to admin_genres_path, notice: 'ジャンル名の登録ができました。'
    else
      redirect_to admin_genres_path, alert: 'ジャンル名の登録ができませんでした。'
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      @genres = Genre.all
      redirect_to admin_genres_path, notice: 'ジャンル名の変更ができました。'
    else
      redirect_to admin_genres_path, alert: 'ジャンル名の変更ができませんでした。'
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end