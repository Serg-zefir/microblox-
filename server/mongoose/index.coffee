mngos = require 'mongoose'

mngos.connect 'mongodb://localhost/tposts'
mngos.connection.once 'open', ->
  console.info 'Data base is open...'
.on 'error', (error) ->
  console.error 'Connect wrong: ', error