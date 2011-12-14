require 'uuid'

class RubymonkClientConfig
  MAX_SANDBOX_SERVERS = 5

  def initialize(config_filename)
    @config_filename = config_filename
  end

  def get
    write_new_config unless File.exists?(@config_filename)
    YAML.load_file(@config_filename)
  end

  def write_new_config
    config = {
        "sandbox_server" => "http://rubymonk-open-#{rand MAX_SANDBOX_SERVERS}.heroku.com/sandbox",
        "sandbox_token" => UUID.new.generate
    }

    File.open(@config_filename, 'w') {|f| f.write(config.to_yaml) }
  end

  def destroy
    File.delete(@config_filename)
  end
end
