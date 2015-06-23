class NotesController < ApplicationController
  before_action :must_be_logged_in_and_owner, only: [:destroy]

  def create
    @note = Note.new(note_params)

    @note.user_id = current_user.id

    if @note.save
      redirect_to track_url(@note.track)
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to track_url(@note.track)
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to track_url(@note.track)
  end

  private
    def note_params
      params.require(:note).permit(:body, :track_id)
    end

    def must_be_logged_in_and_owner
      @note = Note.find(params[:id])
      if @note.user != current_user
        render text: "You are not the owner", status: :forbidden
      end
    end
end
