#!/usr/bin/ruby

require 'optparse'
require 'csv'

class CSVSorter
  def initialize(source_path, order = :ASC, column = 0, delimiter = ',')
    unless column.is_a?(Integer)
      raise '"Column" must be an Integer.'
    end

    unless [:ASC, :DESC].include?(order)
      raise '"Order" must be ASC or DESC.'
    end

    @sorted = false
    @order, @column, @delimiter = order, column, delimiter
    @rows = CSV.parse(File.read(source_path).strip, col_sep: delimiter)
    if column >= @rows[0].length
      raise 'Unexpected column number.'
    end
  end

  def save(output_path)
    unless @sorted
      sort
    end
    CSV.open(output_path, 'w', col_sep: @delimiter) do |csv_object|
      @rows.each do |row_array|
        csv_object << row_array
      end
    end
  end

  private
    def sort
      @rows.sort! do |a, b|
        if a[@column].nil? || a[@column].empty?
          result = -1
        else
          result = (b[@column].nil? || b[@column].empty?) ? 1 : a[@column] <=> b[@column]
        end

        if @order == :DESC
          result * -1
        else
          result
        end
      end
      @sorted = true
    end
end

options = {order: :ASC, column: 0, delimiter: ','}
OptionParser.new do |opts|
  opts.banner = 'Usage: csv_sorter_functional_style.rb [OPTION]... SOURCE_PATH OUTPUT_PATH'

  opts.on('-c', '--column COLUMN_NUMBER', Integer, 'Number column to sort (starts from 0)') do |c|
    options[:column] = c
  end

  opts.on('-o', '--order ORDER', [:DESC, :ASC], 'Order (DESC or ASC)') do |c|
    options[:order] = c
  end

  opts.on('-d', '--delimiter DELIMITER', 'Delimiter') do |c|
    options[:delimiter] = c
  end

  opts.on('-h', '--help', 'Display this screen') do
    puts opts
    exit
  end
end.parse!

if ARGV.length < 2
  puts 'Need specify source and output paths.'
  exit 2
end
source_path = ARGV[0]
output_path = ARGV[1]

begin
  sorter = CSVSorter.new(source_path, options[:order], options[:column], options[:delimiter])
  sorter.save(output_path)
rescue => e
  puts e
  exit 2
end
