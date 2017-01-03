exit 0 unless ENV["BASIC_AUTH_USER"] && ENV["BASIC_AUTH_PASSWORD"]

require "webrick"

DIR = ARGV[0]

file = "#{DIR}/htpasswd"

htpasswd = WEBrick::HTTPAuth::Htpasswd.new(file)
htpasswd.set_passwd(nil, ENV["BASIC_AUTH_USER"], ENV["BASIC_AUTH_PASSWORD"])
htpasswd.flush
