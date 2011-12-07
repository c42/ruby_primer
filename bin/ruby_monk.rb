#! /usr/bin/env ruby

require "rubygems"
require "bundler/setup"

$LOAD_PATH << File.dirname(__FILE__) + "/../lib"
require 'ruby_monk_model'
require 'ruby_monk_client'

require 'fssm'
require 'uuid'

DOCS = File.join(File.dirname(__FILE__), '..', "docs")
TOKEN = UUID.new.generate
SANDBOX_URL = "http://localhost:3000/sandbox"
CLIENT = RubyMonkClient.new(SANDBOX_URL+"/import/create", TOKEN)
UPDATE_FREQUENCY_SECONDS = 5

puts "Visit #{SANDBOX_URL}/?token=#{TOKEN} to see the content.\n\n"

def monitor
  FSSM.monitor(DOCS, '**/*', :directories => true) do
    update { timed_republish }
    delete { timed_republish }
    create { timed_republish }
  end
end

def republish
  content_hash = RubyMonkModel.new(DOCS).build_hash.merge({ "sandbox_token" => TOKEN })
  begin
    response = CLIENT.sync_data(content_hash)
    if response.ok?
      puts "Success."
    elsif response.bad_request?
      puts "Changes not uploaded. Server returned error:"
      puts response.body
    else
      puts "Changes not uploaded. Server returned an error."
    end
  rescue Errno::ECONNREFUSED
    puts "Could not connect to network."
  end
end

def timed_republish
  sleep UPDATE_FREQUENCY_SECONDS
  republish
end

republish
monitor
