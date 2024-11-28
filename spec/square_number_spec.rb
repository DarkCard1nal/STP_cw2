# frozen_string_literal: true

require 'rspec'
require_relative '../task1/square_number'

RSpec.describe SquareNumber do # rubocop:disable Metrics/BlockLength
	describe '.replace_numbers_with_squares_in_file' do
		let(:input_file) { 'input.txt' }
		let(:output_file) { 'output.txt' }

		before do
			# Mock the file reading and writing for this test
			allow(File).to receive(:read).with(input_file).and_return('2 3 4')
			allow(File).to receive(:foreach).with(input_file).and_yield('2 3 4')
			allow(File).to receive(:exist?).with(input_file).and_return(true)
			allow(File).to receive(:write).with(output_file, anything).and_return(nil)
		end

		it 'replaces numbers in the file with their squares' do
			# Test that the method correctly replaces numbers with their squares
			result = SquareNumber.replace_numbers_with_squares_in_file(input_file, output_file)
			expect(result).to eq([4, 9, 16])
		end

		it 'returns an error message if numbers cannot be extracted' do
			# Simulate a failure in the file reading process
			allow(File).to receive(:exist?).with(input_file).and_return(false)
			result = SquareNumber.replace_numbers_with_squares_in_file(input_file, output_file)
			expect(result).to eq("Permission denied: Cannot read to file or file dont exist #{input_file}")
		end
	end

	describe '.square_numbers' do
		it 'returns an array of squared numbers' do
			input = [2, 3, 4]
			expected_result = [4, 9, 16]
			result = SquareNumber.square_numbers(input)
			expect(result).to eq(expected_result)
		end

		it 'works with negative numbers' do
			input = [-2, -3, -4]
			expected_result = [4, 9, 16]
			result = SquareNumber.square_numbers(input)
			expect(result).to eq(expected_result)
		end
	end

	describe '.safe_file_write' do
		let(:file_path) { 'output.txt' }
		let(:content) { 'Some content' }

		it 'writes to the file successfully' do
			allow(File).to receive(:write).with(file_path, content).and_return(nil)
			result = SquareNumber.safe_file_write(file_path, content)
			expect(result).to be_nil
		end

		it 'returns an error message when permission is denied' do
			allow(File).to receive(:write).with(file_path, content).and_raise(Errno::EACCES)
			result = SquareNumber.safe_file_write(file_path, content)
			expect(result).to eq("Permission denied: Cannot write to file #{file_path}")
		end

		it 'returns an error message when file path is invalid' do
			allow(File).to receive(:write).with(file_path, content).and_raise(Errno::ENOENT)
			result = SquareNumber.safe_file_write(file_path, content)
			expect(result).to eq("Invalid file path: #{file_path} does not exist")
		end

		it 'returns an error message for any other error' do
			allow(File).to receive(:write).with(file_path, content).and_raise(StandardError, 'some error')
			result = SquareNumber.safe_file_write(file_path, content)
			expect(result).to eq('An error occurred while writing to the file: some error')
		end
	end

	describe '.extract_numbers_from_file' do
		let(:file_path) { 'input.txt' }

		before do
			allow(File).to receive(:exist?).with(file_path).and_return(true)
		end

		it 'extracts numbers from the file' do
			allow(File).to receive(:foreach).with(file_path).and_yield('text 1 2.5 3')
			result = SquareNumber.extract_numbers_from_file(file_path)
			expect(result).to eq([1.0, 2.5, 3.0])
		end

		it 'returns an error message if file does not exist' do
			allow(File).to receive(:exist?).with(file_path).and_return(false)
			result = SquareNumber.extract_numbers_from_file(file_path)
			expect(result).to eq("Permission denied: Cannot read to file or file dont exist #{file_path}")
		end
	end

	describe '.replace_numbers_in_file' do
		let(:input_file) { 'input.txt' }
		let(:output_file) { 'output.txt' }
		let(:numbers_array) { [4, 9, 16] }

		before do
			allow(File).to receive(:read).with(input_file).and_return('2 3 4')
			allow(File).to receive(:write).with(output_file, anything).and_return(nil)
		end

		it 'replaces numbers in the file with the given numbers array' do
			result = SquareNumber.replace_numbers_in_file(input_file, output_file, numbers_array)
			expect(result).to eq([])
		end

		it 'returns an error message if file writing fails' do
			allow(File).to receive(:write).with(output_file, anything).and_raise(Errno::EACCES)
			result = SquareNumber.replace_numbers_in_file(input_file, output_file, numbers_array)
			expect(result).to eq("Permission denied: Cannot write to file #{output_file}")
		end
	end
end
