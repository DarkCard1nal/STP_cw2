# frozen_string_literal: true

require_relative 'constants'
require_relative 'square_number'

if ARGV.size > 1 # rubocop:disable Style/ConditionalAssignment
	output_file = ARGV[1]
else
	output_file = Constants::OUTPUT_FILE
end
if ARGV.size.positive?
	input_file = ARGV[0]
else
	puts(Constants::AUTHOR)
	puts('You can change the files through arguments:')
	puts('ruby program.rb path/to/input_file.txt path/to/output_file.txt')
	puts("by default used #{Constants::INPUT_FILE} and #{Constants::OUTPUT_FILE}")
	input_file = Constants::INPUT_FILE
end

result = SquareNumber.replace_numbers_with_squares_in_file(input_file, output_file)

p result
