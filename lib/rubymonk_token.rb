class RubymonkToken
  def initialize(token_filename)
    @token_filename = token_filename
  end

  def get_token
    write_token unless File.exists?(@token_filename)
    File.read(@token_filename)
  end

  def write_token
    File.open(@token_filename, 'w') {|f| f.write(UUID.new.generate) }
  end

  def destroy
    File.delete(@token_filename)
  end
end
