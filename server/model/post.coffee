mngos = require 'mongoose'

#create Schema
postSchema = new mngos.Schema(
  title: String
  cdate: { type: Date, default: Date.now }
  body: String
)
  
#create Model and export
exports.Post = mngos.model 'Post', postSchema