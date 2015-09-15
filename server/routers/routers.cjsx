DefaultRoute = ReactRouter.DefaultRoute
NotFoundRoute = ReactRouter.NotFoundRoute
Redirect = ReactRouter.Redirect

routes = (
    <ReactRouter.Route handler={Templates.App} path="/">
        <DefaultRoute handler={Templates.Home} />
        <ReactRouter.Route name="todo" handler={Templates.TodoApp} />
        <ReactRouter.Route name="about" handler={Templates.About} />
        <ReactRouter.Route name="car" handler={Templates.Car}>
            <ReactRouter.Route name="recent-cars" handler={Templates.CarList} />
        </ReactRouter.Route>
        <ReactRouter.Route name="users" handler={Templates.Users} >
            <ReactRouter.Route name="recent-users" handler={Templates.RecentUsers} />
            <ReactRouter.Route name="user" handler={Templates.User} />
        </ReactRouter.Route>
        <NotFoundRoute handler={Templates.NotFound} />
        <Redirect from="company" to="about" />
    </ReactRouter.Route>
)

ReactRouter.run routes, ReactRouter.HistoryLocation, (Handler, state) ->
    React.render(<Handler/>, document.getElementById('application'))
