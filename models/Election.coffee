mongoose = require 'mongoose'

Election = new mongoose.Schema(
  title: String
  numvoters: Number
)

module.exports = mongoose.model 'Election', Election