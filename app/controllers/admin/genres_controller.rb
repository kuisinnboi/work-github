class Admin::GenresController < ApplicationController
  def index
    records_per_page = 10
    current_page = params[:page].to_i
    current_page = 1 if current_page.zero?
    offset = (current_page - 1) * records_per_page
    @current_page = current_page
    @genres = Genre.offset(offset).limit(records_per_page)
    @total_pages = (Genre.count.to_f / records_per_page).ceil
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
