class TracksController < ApplicationController
  before_action :logged_in?
  before_action :admin?, only: [:create, :update, :destroy]

  def new
    @track = Track.new
    @albums = Album.all
    @album = Album.find(params[:album_id])
    render :new
  end

  def create
    @track = Track.new(track_params)
    @albums = Album.all
    @album = Album.find(params[:track][:album_id])

    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.all
    @album = Album.find(@track.album.id)
  end

  def show
    @track = Track.find(params[:id])
    @note = Note.new
    render :show
  end

  def update
    @track = Track.find(params[:id])
    @albums = Album.all
    @album = Album.find(@track.album.id)

    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to album_url(@track.album)
  end

  private
    def track_params
      params.require(:track).permit(:album_id, :name, :bonus, :lyrics)
    end
end
