exit 0 unless ENV["BASIC_AUTH_USER"] && ENV["BASIC_AUTH_PASSWORD"]

require "webrick"
require "fileutils"

DIR = ARGV[0]

file = "#{DIR}/htpasswd"
FileUtils.touch(file)

htpasswd = WEBrick::HTTPAuth::Htpasswd.new(file)
htpasswd.set_passwd(nil, ENV["BASIC_AUTH_USER"], ENV["BASIC_AUTH_PASSWORD"])
htpasswd.flush
