require 'csv'

class CsvBuilder
  attr_accessor :output, :header, :data

  def initialize(header, data)
    @header = header
    @data = data
  end

  def build
    Enumerator.new do |output|
      output << CSV.generate_line(header)
      data.find_each do |datum|
        row = [datum.id, datum.name, datum.duration]
        output << CSV.generate_line(row)
      end
      output
    end
  end
end