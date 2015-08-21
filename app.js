var coffee = require('coffee-script'); coffee.register();

var express = require('express'),
    app = express();

app.set('views', './app/views');
app.set('view engine', 'jade');
app.use(express.static('./build/assets'));

app.get('/', function (req, res) {
    res.render('home', {});
});

app.listen(7000);