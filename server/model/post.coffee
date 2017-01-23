mngos = require 'mongoose'
Schema = mngos.Schema
#create Schema
postSchema = new Schema
  title: String
  cdate: { type: Date, default: Date.now }
  body: String #html
#create Model
post = mngos.model 'Post', postSchema
exports.Post = post