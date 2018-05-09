require 'net/http'
require 'json'

def download(token, source, debug)
  body = JSON.parse(Net::HTTP.get(URI("https://slack.com/api/emoji.list?token=#{token}")))
  body['emoji'].each do |name, src|
    src.match(/(\.\w{3}\z)/)
    ext = $1
    if !ext.nil?
      filename = "#{name}#{ext}"
      filepath = "#{source}/#{filename}"
      if !File.exists?(filepath)
        puts "Saving #{filename}" if debug
        system("wget --quiet -O \"#{filepath}\" #{src} >/dev/null")
      else
        puts "Skipping #{filename}" if debug
      end
    end
  end
end

while true
  begin
    start = Time.now
    puts "Starting download"
    download(ENV['TOKEN'], ENV['SOURCE'], ENV['DEBUG'] != '')
    puts "Finishing download after #{Time.now - start} seconds"
  rescue e
    puts "Download failed: #{e}"
  end
  sleep(12 * 60 * 60) # 12 hours
end
