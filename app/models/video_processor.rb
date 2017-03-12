require 'streamio-ffmpeg'

class VideoProcessor < ActiveRecord::Base
  attr_reader :movie

  def initialize(video_path)
    @video_path = video_path
    @movie = FFMPEG::Movie.new(@video_path)
    @file_name = @video_path.split('/').last.chomp('.webm')# @url.split('/').last.chomp("#{File.extname(@url)}")
  end

  def video_with_watermark(watermark_path = default_watermark_path, position = 'RB', padding_x = 10, padding_y = 10)
    options = {
      watermark: watermark_path,
      resolution: @movie.resolution,
      watermark_filter: { 
        position: position,
        padding_x: padding_x,
        padding_y: padding_y
      }
    }
    
    
    movie.transcode("tmp/#{@file_name}.mp4", options)

    chunk_size = 32
    Enumerator.new do |output|
      File.open("tmp/#{@file_name}.mp4", 'br') do |file|
        output << chunk
      end
      output
    end
  end

  def create_thumbnail(format = 'png', quality = 3)
    movie.screenshot("tmp/#{@file_name}.#{format}", quality: quality)
  end

  private

  def default_watermark_path
    Rails.root.join('bigsofa.png')
  end
end