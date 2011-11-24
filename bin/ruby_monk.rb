$LOAD_PATH << '../lib'

require 'ruby_monk_model'
require 'ruby_monk_client'

require 'fssm'

DOCS = File.join(File.dirname(__FILE__), '..', "docs")
CLIENT = RubyMonkClient.new 
TOKEN = CLIENT.generate_token

def monitor
  FSSM.monitor(DOCS, '**/*', :directories => true) do
    update { republish }
    delete { republish }
    create { republish }
  end
end

def republish
  content_hash = RubyMonkModel.new(DOCS).build_hash.merge TOKEN
  puts content_hash
  CLIENT.sync_data(content_hash)
end

republish
monitor
