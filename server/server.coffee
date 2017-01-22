http = require 'http'
express = require 'express'
path    = require 'path'
bPar = require 'body-parser'
mngos = require 'mongoose'
api  = require './api'
dbase = require './mongoose'

app = express()
port = 3000
assetsPath = path.join __dirname, 'public'

app.use bPar.urlencoded(extended: true)
app.use bPar.json()
app.use express.static assetsPath

app.post   '/api/post',     api.addPost
app.get    '/api/post',     api.posts
app.get    '/api/post/:id', api.post
app.put    '/api/post/:id', api.editPost
app.delete '/api/post/:id', api.removePost
app.get    '*',             (req, res) ->
  res.sendfile "#{assetsPath}/index.html"

http.createServer(app).listen port, ->
  console.log 'Server magic on port ' + port