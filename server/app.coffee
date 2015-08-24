express = require 'express'; app = express()
fs = require 'fs'

app.set 'views', './server/views'
app.set 'view engine', 'jade'
app.use express.static('./build/assets')

fs.readdirSync("#{__dirname}/models").forEach (filename) ->
  require "#{__dirname}/models/#{filename}" if ~filename.indexOf('.coffee')

app.get '/', (req, res) -> res.render 'home', {}

app.listen(7000)