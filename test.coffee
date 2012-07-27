express = require('express')

app = express.createServer(express.logger())
app.get '/', (request, response) ->
  response.send('Hell World!')

port = process.env.PORT || 5000;
app.listen port, ->
  console.log("Listening on " + port)