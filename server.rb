require 'sinatra'
require 'net/http'

def get_status
    begin
        uri = URI('https://www.posta-romana.ro/cnpr-app/modules/track-and-trace/ajax/status.php')
        req = Net::HTTP::Post.new(uri, initheader = {
            'Content-Type' =>'application/x-www-form-urlencoded; charset=UTF-8',
            'Referer' => 'https://www.posta-romana.ro/track-trace.html',
            'Accept' => 'application/json, text/javascript, */*; q=0.01',
            'X-Requested-With' => 'XMLHttpRequest',
            'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36'
        })
        req.body = "awb=#{ENV['AWB']}"
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
          response = http.request(req)
          puts "#{response.code} => #{response.body}"
          return response.body
        end
      rescue => e
        STDERR.puts "failed: #{e}"
      end
end

get '/check' do
    _status = get_status
    if _status == '{"found":false}'
        status 200
        "No worries:  #{ENV['AWB']} => #{_status}"
    else
        status 500
        "Pazea, e in ro! => #{_status}"
    end

end
get '/' do
    "Hello World!"
end
