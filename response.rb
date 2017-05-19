class Response
  attr_reader :code, :headers

  def initialize(code:, headers:, data: "")
    @response =
      "HTTP/1.1 #{code}\r\n" +
        "Content-Length: #{data.size}\r\n" +
        "\r\n" +
        "#{data}\r\n"
    @code = code
    @headers = headers
  end

  def send(client)
    client.write(@response)
  end
end
