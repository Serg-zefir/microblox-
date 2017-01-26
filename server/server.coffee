http = require 'http'
app = require './app'
port = 3000

http.createServer(app).listen port, ->
  console.log 'Server magic on port ' + port