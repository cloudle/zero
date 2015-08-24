mongoose = require('mongoose');
Schema = mongoose.Schema;

usersSchema = new Schema({
  name: String
});

mongoose.model('users', usersSchema)