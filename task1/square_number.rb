# frozen_string_literal: true

# module SquareNumber
module SquareNumber
	def self.replace_numbers_with_squares_in_file(input_file_path, output_file_path)
		numbers = extract_numbers_from_file(input_file_path)
		return numbers if numbers.is_a?(String)

		numbers = square_numbers(numbers)
		result = replace_numbers_in_file(input_file_path, output_file_path, numbers.dup)
		return result if result.is_a?(String)

		numbers
	end

	def self.square_numbers(array)
		threads = []
		array.each_with_index do |num, index|
			threads << Thread.new do
				array[index] = num**2
			end
		end

		threads.each(&:join)
		array
	end

	def self.safe_file_write(file_path, content)
		File.write(file_path, content)
		nil
	rescue Errno::EACCES
		"Permission denied: Cannot write to file #{file_path}"
	rescue Errno::ENOENT
		"Invalid file path: #{file_path} does not exist"
	rescue StandardError => e
		"An error occurred while writing to the file: #{e.message}"
	end

	def self.extract_numbers_from_file(file_path)
		numbers = []
		if File.exist?(file_path)
			File.foreach(file_path) do |line|
				line.scan(/[-+]?\d*\.\d+|[-+]?\d+/) do |match|
					numbers << match.to_f
				end
			end
			return numbers
		end

		"Permission denied: Cannot read to file or file dont exist #{file_path}"
	end

	def self.replace_numbers_in_file(input_file_path, output_file_path, numbers_array)
		file_content = File.read(input_file_path)

		file_content.gsub!(/[-+]?\d*\.\d+|[-+]?\d+/) do
			numbers_array.shift.to_s
		end

		result = safe_file_write(output_file_path, file_content)
		result.is_a?(String) ? result : numbers_array
	end
end
