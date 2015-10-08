#!/usr/bin/ruby

require 'optparse'
require 'csv'

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

rows = CSV.parse(File.read(source_path).strip, col_sep: options[:delimiter])

if options[:column] >= rows[0].length
  puts 'Unexpected column number.'
  exit 2
end

rows.sort! do |a, b|
  if a[options[:column]].nil? || a[options[:column]].empty?
    result = -1
  else
    result = (b[options[:column]].nil? || b[options[:column]].empty?) ? 1 : a[options[:column]] <=> b[options[:column]]
  end

  if options[:order] == :DESC
    result * -1
  else
    result
  end
end

CSV.open(output_path, 'w', col_sep: options[:delimiter]) do |csv_object|
  rows.each do |row_array|
    csv_object << row_array
  end
end

exit 0
