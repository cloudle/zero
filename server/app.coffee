express = require 'express'; app = express();
apiRouter = express.Router(); classicRouter = express.Router()
React = require 'react'; Router = require 'react-router'
fs = require 'fs'
#reactBundle = require './react-bundle'

app.set 'views', './server/views'
app.set 'view engine', 'jade'
app.use express.static('./build/assets')

fs.readdirSync("#{__dirname}/models").forEach (filename) ->
  require "#{__dirname}/models/#{filename}" if ~filename.indexOf('.coffee')

classicRouter.get '*', (req, res) ->
  console.log('server rendering..');
  res.render 'home', {}
#  Router.run reactBundle.routes, req.path, (Root, state) ->
#    res.render 'home', { staticContent: React.renderToString(React.createElement(Root, null))}

apiRouter.get '/', (req, res) ->
  res.json message: 'yay!'

apiRouter.route('/users')
  .get (req, res) ->
    res.json message: "i know, you're looking for user"

  .post (req, res) ->
    console.log 'someone post to /users'

app.use '/api', apiRouter
app.use '/', classicRouter

app.listen(7000)