RouteHandler = ReactRouter.RouteHandler
Link = ReactRouter.Link

App = React.createClass
    getInitialState: ->
        appName: 'Zero!'
    render: ->
        <div>
            <Link to="todo">Todo</Link>
            <Link to="about">Go to {@state.appName} About</Link>
            <Link to="users">Go to Users</Link>
            <Link to="car">Go to Car</Link>
            <Link to="recent-cars">Go to Cars</Link>
            <RouteHandler />
        </div>