require "cuatrocientoscuatro/version"

module Cuatrocientoscuatro
  require 'socket'
  require 'uri'

  WEB_ROOT = './public'
  CONTENT_TYPE_MAPPING = {
    'html' => 'text/html',
    'txt' => 'text/plain',
    'png' => 'image/png',
    'jpg' => 'image/jpeg'
  }
  DEFAULT_CONTENT_TYPE = 'application/octet-stream'

  def content_type(path)
    ext = File.extname(path).split(".").last
    CONTENT_TYPE_MAPPING.fetch(ext, DEFAULT_CONTENT_TYPE)
  end

  def requested_file(request_line)
    request_uri = request_line.split(" ")[1]
    path        = URI.unescape(URI(request_uri).path)

    clean = []

    parts = path.split("/")

    parts.each do |part|
      next if part.empty? || part == '.'
      part == '..' ? clean.pop : clean << part
    end

    File.join(WEB_ROOT, path)
  end

  server = TCPServer.new('localhost', 9999)

  loop do
    socket = server.accept
    request_line = socket.gets

    STDERR.puts request_line

    path = requested_file(request_line)

    if File.exist?(path) && !File.directory?(path)
      File.open(path, "rb") do |file|
        socket.print "HTTP/1.1 DOCIENTOS OK\r\n" +
                     "Typo-Contenido: #{content_type(file)}\r\n" +
                     "Largo-Contenido: #{file.size}\r\n" +
                     "Conneccion: cerrado\r\n"
          socket.print "\r\n"

          IO.copy_stream(file, socket)
      end
    else
      message = "Archivo no encontrado\n"
      socket.print "HTTP/1.1 CUATROCIENTOSCUATRO VATO\r\n" +
                    "Typo-Contenido: text/plain\r\n" +
                    "Largo-Contenido: #{message.size}\r\n" +
                    "Conneccion: cerrado\r\n"
        socket.print "\r\n"

        socket.print message
    end

    socket.close
  end
end
