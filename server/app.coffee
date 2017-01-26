express = require 'express'
path    = require 'path'
bPar = require 'body-parser'
mngos = require 'mongoose'
api  = require './api'
dbase = require './mongoose'

app = express()
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

module.exports = app