const mongoose = require('mongoose');
const UserSchema = new mongoose.Schema({}, {strict: false});
const User = mongoose.model('User', UserSchema, 'users');

module.exports = User;