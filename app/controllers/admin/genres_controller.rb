class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "created successfully"
    else
      render admin_genres_path
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre =Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "update successfully"
    else
      render edit_admin_genre_path(@genre)
    end
  end
  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
