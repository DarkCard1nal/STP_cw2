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
	'https://www.google.com',
	'https://github.com',
	'https://discord.com',
	'https://www.youtube.com'
]

threads = urls.map do |url|
	Thread.new { fetch_url(url) }
end

threads.each(&:join)

puts 'All requests completed!'
