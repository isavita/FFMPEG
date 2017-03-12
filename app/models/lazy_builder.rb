class LazyBuilder
  attr_accessor :data

  def initializer(data)
    @data = data
  end

  def build
    Enumerator.new do |output|
    end
  end
end