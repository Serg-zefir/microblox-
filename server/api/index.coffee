data = require '../model/post'

# create
exports.addPost = (req, res) ->
  data.Post.create req.body, (err, post) ->
    if err
      res.send "Error occurred creating post", 404
    else
      res.send "Post created happily"

# read index
exports.posts = (req, res) ->
  data.Post.find (err, posts) ->
    if err
      res.send "Error occurred getting posts", 404
    else
      res.send posts

# read post
exports.post = (req, res) ->
  data.Post.findOne {'_id': req.params.id}, (err, post) ->
    if err
      res.send "Error occurred getting this post", 404
    else
      res.send post

# update
exports.editPost = (req, res) ->
  data.Post.findOneAndUpdate {'_id': req.params.id}, req.body, (err) ->
    if err
      res.send "Error occurred removing post", 404
    else
      res.send "Post happily updated"

# destroy
exports.removePost = (req, res) ->
  data.Post.findOneAndRemove {'_id': req.params.id}, (err) ->
    if err
      res.send "Error occurred removing this post", 404
    else
      res.send "Post removed happily"