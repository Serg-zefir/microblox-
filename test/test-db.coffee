mngos = require 'mongoose'

describe 'MongoDB test', ->

  it '--> Test DB', (done) ->
    mngos.connect "mongodb://localhost/testblog"
    mngos.connection
      .once 'open', -> done()
      .on 'error', (error) ->
        console.warn 'Connect wrong: ', error