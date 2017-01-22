angular.module('blogger.services', ['ngResource'])

.factory 'Post', ($resource) ->
  $resource '/api/post/:id', null,
    'update': { method: 'PUT' }
