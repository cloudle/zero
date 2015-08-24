mongoose = require('mongoose');
Schema = mongoose.Schema;

postsSchema = new Schema({
  content: String
  user:
    type: Schema.ObjectId
    ref: 'users'
});

mongoose.model('posts', postsSchema)