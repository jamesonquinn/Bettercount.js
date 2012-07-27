mongoose = require 'mongoose'
Election     = require '../models/Election'

describe 'New Election', ->
  before (done) ->
    mongoose.connect 'mongodb://localhost/bettercount', ->
      Election.remove done
  it 'should save a new election', (done) ->
    election = new Election(title:'First!', numvoters:'42')
    election.save ->
      Election.findOne _id: election._id, (err, retrievedElection) ->
        retrievedElection.title.should.eql "First!"
        retrievedElection.numvoters.should.eql 42
        done()