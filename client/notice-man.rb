require 'httpclient'
require 'yaml'
require "optparse"
require 'pp'
require 'json'
require 'pathname'

options = { :secret => "topsecret", :endpoint => "https://notice.ubiregi.com" }

ARGV.options do |opts|
  opts.banner = "Usage:  #{File.basename($PROGRAM_NAME)} [OPTIONS] COMMANDS"

  opts.separator ""
  opts.separator "Specific Options:"

  opts.on("--secret=SECRET", "Secret") do |secret|
    options[:secret] = secret
  end

  opts.on("--endpoint=ENDPOINT", "API endpoint") do |endpoint|
    options[:endpoint] = endpoint.gsub(/\/$/, '')
  end

  opts.separator "Common Options:"

  opts.on( "-h", "--help", "Show this message." ) do
    puts opts
    puts "Available commands:"
    puts "  list: show notices"
    puts "  post notice.yml: post new notice"
    puts "  update id notice.yml: update existing notice with id"
    puts "  close id: close notice"
    exit
  end

  begin
    opts.parse!
  rescue
    puts opts
    exit
  end
end

client = HTTPClient.new

case ARGV.shift || "list"
when "list"
  content = JSON.parse(client.get_content(options[:endpoint] + "/notices"))
  pp content["notices"]
when "post"
  body = YAML.load(Pathname(ARGV.first).read)
  data = { :notice => body }.to_json
  content = JSON.parse(client.post(options[:endpoint] + "/notices",
                                   data,
                                   { "content-type" => "application/json",
                                     "X-UBIREGI-NOTICE-SECRET" => options[:secret] }).body)
  pp content["notice"]
when "close"
  id = ARGV.first.to_i
  content = JSON.parse(client.post(options[:endpoint] + "/notices/#{id}/close",
                                   "",
                                   "X-UBIREGI-NOTICE-SECRET" => options[:secret]).body)
  pp content["notice"]
when "update"
  id = ARGV[0].to_i
  body = YAML.load(Pathname(ARGV[1]).read)
  data = { :notice => body }.to_json
  result = client.put(options[:endpoint] + "/notices/#{id}",
                      data,
                      { "content-type" => "application/json",
                        "X-UBIREGI-NOTICE-SECRET" => options[:secret] })
  content = JSON.parse(result.body)
  pp content["notice"]
end
