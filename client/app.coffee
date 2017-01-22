angular.module('blogger', [
  'ngRoute',
  'blogger.controllers', 'blogger.services',
  'partials'
])
.config ($routeProvider, $locationProvider) ->
  $routeProvider

    .when '/',
      templateUrl: '/partials/postIndex.html'
      controller:  'PostsController'

    .when '/posts/new',
      templateUrl: '/partials/postNew.html'
      controller:  'AddPostController'

    .when '/post/edit/:id',
      templateUrl: '/partials/postEdit.html'
      controller:  'EditPostController'

    .when '/post/:id',
      templateUrl: '/partials/postShow.html'
      controller:  'ShowPostController'

    .otherwise redirectTo: '/'

  $locationProvider.html5Mode true
