require 'wrest'
require 'json'

class RubyMonkClient

  def initialize
    @token_url = "http://localhost:3000/sandbox/token/create"
    @post_url = "http://localhost:3000/sandbox/import/create"
  end

  def authenticate
    @token_url.to_uri.post.deserialise
  end

  def sync_data(chapters_hash)
    @post_url.to_uri.post(chapters_hash.to_json, 'Content-Type' => 'application/json') 
  end
end
