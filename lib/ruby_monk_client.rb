require 'wrest'
require 'json'

class RubyMonkClient
  def initialize(post_url, auth_token)
    @post_url = post_url
    @auth_token = auth_token
  end

  def sync_data(chapters_hash)
    @post_url.to_uri.post(chapters_hash.to_json, 'Content-Type' => 'application/json')
  end
end
