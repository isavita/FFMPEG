class TranscriptVersion
  include TranscriptVersionsRedis

  def initialize(transcript)
    @transcript_id = transcript.is_a?(Transcript) ? transcript.id : transcript
  end

  def store(data)
    data = valid_json?(data) ? data : data.to_json
    redis.lpush(transcript_key, data)
  end

  def undo
    return unless undo?
    transcript = redis.lpop(transcript_key)
    redis.lpush(transcript_undo_key, transcript)
    JSON.parse(transcript)
  rescue JSON::ParserError
    { 'error' => "JSON::ParserError on #{transcript_key}" }
  end

  def redo
    return unless redo? 
    transcript = redis.lpop(transcript_undo_key)
    redis.lpush(transcript_key, transcript)
    JSON.parse(transcript)
  rescue JSON::ParserError
    { 'error' => "JSON::ParserError on #{transcript_undo_key}" }
  end

  def undo?
    redis.llen(transcript_key) != 0
  end

  def redo?
    redis.llen(transcript_undo_key) != 0
  end

  private
  def valid_json?(json)
    return false unless json.is_a?(String)
    begin
      JSON.parse(json)
      return true
    rescue JSON::ParserError
      return false
    end
  end

  def transcript_key
    "transcript_version:#{@transcript_id}"
  end

  def transcript_undo_key
    "transcript_version_undo:#{@transcript_id}"
  end
end
