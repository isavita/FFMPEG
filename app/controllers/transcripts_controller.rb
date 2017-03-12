class TranscriptsController < ApplicationController
  before_action :load_transcript_version, only: [:update_transcript_ajax, :undo_transcript, :redo_transcript]

  def index
    @transcripts = Transcript.all
  end

  def create
    if Transcript.create(transcript_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def edit
    @transcript = Transcript.find(params[:id])
  end

  def undo_transcript
    @version = @transcript_version.undo
    respond_to do |format|
      format.html { redirect_to edit_transcript_path(params[:transcript_id]) }
      format.js { }
    end
  end

  def redo_transcript
    @version = @transcript_version.redo
    respond_to do |format|
      format.html { redirect_to edit_transcript_path(params[:transcript_id]) }
      format.js { }
    end
  end

  def update_transcript_ajax
    @transcript_version.store(params[:transcript])
    respond_to do |format|
      format.html { redirect_to edit_transcript_path(params[:transcript_id]) }
      format.js { }
    end
  end

  def update
    @transcript = Transcript.find(params[:id])
    @transcript.update_attributes(transcript_params)
    redirect_to edit_transcript_path(@transcript)
  end

  private

  def transcript_params
    params.require(:transcript).permit(:name, :content, :language)
  end

  def load_transcript_version
    @transcript_version = TranscriptVersion.new(params[:transcript_id])
  end
end
