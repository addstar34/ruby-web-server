$LOAD_PATH.unshift('.')

require 'socket'
require 'request_parser'
require 'response_preparer'

PORT = 8081
SERVER_ROOT = './app/views/layouts/'

server = TCPServer.new('localhost', PORT)

loop {
  client = server.accept
  request = client.readpartial(2048)


  request = RequestParser.parse(request)
  response = ResponsePreparer.prepare(request)

  puts "#{client.peeraddr} #{request.fetch(:path)} - #{response.code}"

  response.send(client)
  client.close
}
