const mngos = require('mongoose');

mngos.connect('mongodb://localhost/posts');

mngos.connection.once('open', function () {
  console.log('DB is open...');
}).on('error', function (error) {
  console.log('Connect wrong: ', error);
});