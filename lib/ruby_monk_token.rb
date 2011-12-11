class RubyMonkToken
  def initialize(token_path)
    @uuid_new = UUID.new
    @token_file = File.new(token_path, File::CREAT, 0600)
  end

  def get_token
    exists? ? read_token : write_token
  end

  private  
  def read_token
    @token_file.first
  end

  def write_token
    token = @uuid_new.generate
    File.open(@token_file, "w") { |file| file.write(token) }
    token
  end

  def exists?
    (not read_token.nil?) ? (not read_token.empty?) : false
  end
end
