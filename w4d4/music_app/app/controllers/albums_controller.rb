class AlbumsController < ApplicationController
  before_action :logged_in?
  before_action :admin?, only: [:create, :update, :destroy]

  def new
    @bands = Band.all
    @album = Album.new
    @band = Band.find(params[:band_id])
    render :new
  end

  def create
    @bands = Band.all
    @band = Band.find(params[:album][:band_id])
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @bands = Band.all
    @album = Album.find(params[:id])
    @band = @album.band
    render :edit
  end

  def update
    @bands = Band.all
    @album = Album.find(params[:id])
    @band = @album.band
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end


  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to band_url(@album.band)
  end
  private
    def album_params
      params.require(:album).permit(:band_id, :name, :live_studio_type)
    end
end
