#! /usr/bin/env ruby

require "rubygems"
require "bundler/setup"

$LOAD_PATH << File.dirname(__FILE__) + "/../lib"
require 'ruby_monk_model'
require 'ruby_monk_client'

require 'fssm'

DOCS = File.join(File.dirname(__FILE__), '..', "docs")
CLIENT = RubyMonkClient.new
TOKEN = CLIENT.generate_token
UPDATE_FREQUENCY_SECONDS = 5

def monitor
  FSSM.monitor(DOCS, '**/*', :directories => true) do
    update { timed_republish }
    delete { timed_republish }
    create { timed_republish }
  end
end

def republish
  content_hash = RubyMonkModel.new(DOCS).build_hash.merge TOKEN
  response = CLIENT.sync_data(content_hash)
  if response.ok?
    puts "Success."
  else
    puts "Changes not uploaded. Server return an error"
  end
end

def timed_republish
  sleep UPDATE_FREQUENCY_SECONDS
  republish
end

republish
monitor
