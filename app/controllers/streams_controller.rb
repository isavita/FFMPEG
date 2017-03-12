require 'redis'

class StreamsController < ApplicationController
  HOST = '127.0.0.1'
  PORT = 6379
  DATABASE = 1
  @@redis = Redis.new(host: HOST, port: PORT, db: DATABASE)

  def index
    @message = @@redis.get('1')
    gon.message = @message
  end

  def show
    csv_builder = CsvBuilder.new(%w(id name duration), Video)
    respond_to do |format|
      format.html {}
      format.csv do
        headers['X-Accel-Buffering'] = 'no'
        headers['Cache-Control'] = 'no-cache'
        headers['Content-Type'] = 'text/csv; charset=utf-8'
        headers['Content-Disposition'] = %(attachment; filename="#{csv_filename}")
        headers['Last-Modified'] = Time.zone.now.ctime.to_s
        self.response_body = csv_builder.build
      end
    end
  end

  def message
    @@redis.set(params[:media_id], params[:message])
    redirect_to action: :index
  end

  def video_download
    vp = VideoProcessor.new('/home/baruh/git/ffmpeg_test/joseph.webm')

    # headers['X-Accel-Buffering'] = 'no'
    # headers['Cache-Control'] = 'no-cache'
    # headers['Content-Type'] = 'video/mp4'
    # headers['Content-Disposition'] = %(attachment; filename="video_with_watermark_#{Time.zone.now.to_s}.mp4")
    # headers['Last-Modified'] = Time.zone.now.ctime.to_s
    # self.response_body = 
    vp.video_with_watermark
  end

  private

  def csv_filename
    "report-#{Time.zone.now.to_date.to_s(:default)}.csv"
  end
end
