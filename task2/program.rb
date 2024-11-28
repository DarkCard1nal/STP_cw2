# frozen_string_literal: true

require 'net/http'
require 'uri'

def fetch_url(url) # rubocop:disable Metrics/MethodLength
	uri = URI.parse(url)
	response = nil

	begin
		Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
			request = Net::HTTP::Get.new(uri)
			response = http.request(request)
		end
		puts "Fetched #{url}: #{response.code} #{response.message}"
	rescue StandardError => e
		puts "Error fetching #{url}: #{e.message}"
	end

	response
end

urls = [
	'https://jsonplaceholder.typicode.com/posts/1',
	'https://jsonplaceholder.typicode.com/posts/2',
	'https://jsonplaceholder.typicode.com/posts/3',
	'https://jsonplaceholder.typicode.com/posts/4'
]

threads = urls.map do |url|
	Thread.new { fetch_url(url) }
end

threads.each(&:join)

puts 'All requests completed!'
