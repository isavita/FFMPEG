class RedisStore
  HOST = '127.0.0.1'
  PORT = 6379
  DATABASE = 1
  @@redis = Redis.new(host: HOST, port: PORT, db: DATABASE)

  def self.set(key, value)
    @@redis.set(key, value)
  end

  def self.get(key)
    @@redis.get(key)
  end
end