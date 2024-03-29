
###
Module dependencies.
###
express = require("express")
routes = require("./routes")
http = require("http")
path = require("path")
app = express()
app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  app.use express.errorHandler()
  Sideline = require "sideline"
  Sideline.with(server: app).listen()

app.get "/", routes.index
app.get "/election/new", routes.newElection
app.post "/election/new", routes.addElection
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

