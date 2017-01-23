mngos = require 'mongoose'

mngos.connect 'mongodb://localhost/tposts'
mngos.connection.once 'open', ->
  console.log 'Data base is open...'
.on 'error', (error) ->
  console.log 'Connect wrong: ', error