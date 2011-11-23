require 'wrest'
require 'json'
require 'uuid'

class RubyMonkClient
  def initialize
    @post_url = "http://localhost:3000/sandbox/import/create"
    @auth_token = UUID.new
  end

  def generate_token
    { "sandbox_token" => @auth_token.generate }
  end

  def sync_data(chapters_hash)
    @post_url.to_uri.post(chapters_hash.to_json, 'Content-Type' => 'application/json') 
  end
end
