module TranscriptVersionsRedis
  mattr_accessor :redis

  ENV_CONFIG = {
    host: '127.0.0.1',
    port: '6379',
    namespace: 'transcript_versions',
    db: '1',
  }

  @@redis = Redis.new(ENV_CONFIG)

  def self.reconnect
    @@redis = Redis.new(ENV_CONFIG)
  end

  def self.flushdb
    @@redis.flushdb
  end
end