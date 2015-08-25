RouteHandler = ReactRouter.RouteHandler
Link = ReactRouter.Link

App = React.createClass
    render: ->
        <div>
            <Link to="about">Go to About</Link>
            <Link to="users">Go to Users</Link>
            <Link to="car">Go to Car</Link>
            <Link to="recent-cars">Go to Cars</Link>
            <RouteHandler />
        </div>
