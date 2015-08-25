Route = ReactRouter.Route
DefaultRoute = ReactRouter.DefaultRoute
NotFoundRoute = ReactRouter.NotFoundRoute
Redirect = ReactRouter.Redirect

routes = (
    <Route handler={App} path="/">
        <DefaultRoute handler={Home} />
        <Route name="about" handler={About} />
        <Route name="car" handler={Car}>
            <Route name="recent-cars" handler={CarList} />
        </Route>
        <Route name="users" handler={Users} >
            <Route name="recent-users" handler={RecentUsers} />
            <Route name="user" handler={User} />
        </Route>
        <NotFoundRoute handler={NotFound} />
        <Redirect from="company" to="about" />
    </Route>
)

ReactRouter.run routes, ReactRouter.HistoryLocation, (Handler, state) ->
    React.render(<Handler/>, document.getElementById('content'))
