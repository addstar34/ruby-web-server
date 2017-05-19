require 'response'

class ResponsePreparer
  def initialize(request)
    @request = request
  end

  def self.prepare(request)
    new(request).prepare
  end

  def prepare
    if @request.fetch(:path) == "/"
      respond_with(SERVER_ROOT + "index.html")
    else
      respond_with(SERVER_ROOT + @request.fetch(:path))
    end
  end

  def respond_with(path)
    if File.exists?(path)
      send_ok_response(File.binread(path))
    else
      send_file_not_found
    end
  end

  def send_ok_response(data)
    Response.new(code: 200, data: data, headers: @request.fetch(:headers))
  end

  def send_file_not_found
    Response.new(code: 404, headers: @request.fetch(:headers))
  end
end
