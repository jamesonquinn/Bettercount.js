Election     = require '../models/Election'

module.exports = 
  index: (req, res) ->
    Election.find {}, (err, elections) ->
      res.render "index",
        title: "Better Count Us"
        elections: elections

  newElection: (req, res) ->
    res.render 'add_election', title:"Create new election"
    

  addElection: (req, res) ->
    new Election(req.body.post).save ->
      res.redirect "/"