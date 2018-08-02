require 'httparty'

token = "4817cf861b3ed565a67c4adcf253b031"
url = "http://localhost:3000/api/projects/1/tickets/1.json"

response = HTTParty.get(url,
  headers: {
    "Authorization" => "Token token=#{token}"
  }
)

puts response.parsed_response
