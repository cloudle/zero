express = require 'express'; app = express()
React = require 'react'; Router = require 'react-router'
fs = require 'fs'
#reactBundle = require './react-bundle'

app.set 'views', './server/views'
app.set 'view engine', 'jade'
app.use express.static('./build/assets')

fs.readdirSync("#{__dirname}/models").forEach (filename) ->
  require "#{__dirname}/models/#{filename}" if ~filename.indexOf('.coffee')

app.get '/*', (req, res) ->
  console.log('server rendering..');
  res.render 'home', {}
#  Router.run reactBundle.routes, req.path, (Root, state) ->
#    res.render 'home', { staticContent: React.renderToString(React.createElement(Root, null))}

app.listen(7000)