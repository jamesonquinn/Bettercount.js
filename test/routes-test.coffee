routes = require "../routes/index"
mongoose = require "mongoose"
Election     = require "../models/Election"
require "should"

describe "routes", ->
  req = 
    params: {}
    body: {}
  res = 
    redirect: (route) ->
      # do nothing
    render: (view, vars) -> 
      # do nothing
  before (done) ->
    mongoose.connect 'mongodb://localhost/bettercount', ->
      Election.remove done
      
  describe "index", ->
    it "should display index with elections", (done) ->
      res.render= (view, vars) ->
          view.should.equal "index"
          vars.title.should.equal "Better Count Us"
          vars.elections.should.eql []
          done()
      routes.index(req, res)
      
  describe "new election", ->
    it "should display the add election page", (done) ->
      res.render = (view, vars) ->
          view.should.equal "add_election"
          vars.title.should.equal "Create new election"
          done()

      routes.newElection req, res
      
    it "should add a new election when requested", (done) ->
      req.body.post =
          title: "My Election!"
          numvoters: "3"

      routes.addElection req, redirect: (route) ->
        route.should.eql "/"
        routes.index req, render: (view, vars) ->
          view.should.equal "index"
          vars.elections[0].title.should.eql 'My Election!'
          vars.elections[0].numvoters.should.eql 3
          done()