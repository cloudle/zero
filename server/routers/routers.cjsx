DefaultRoute = ReactRouter.DefaultRoute
NotFoundRoute = ReactRouter.NotFoundRoute
Redirect = ReactRouter.Redirect

routes = (
    <ReactRouter.Route handler={Components.App} path="/">
        <DefaultRoute handler={Components.Home} />
        <ReactRouter.Route name="todo" handler={Components.TodoApp} />
        <ReactRouter.Route name="about" handler={Components.About} />
        <ReactRouter.Route name="car" handler={Components.Car}>
            <ReactRouter.Route name="recent-cars" handler={Components.CarList} />
        </ReactRouter.Route>
        <ReactRouter.Route name="users" handler={Components.Users} >
            <ReactRouter.Route name="recent-users" handler={Components.RecentUsers} />
            <ReactRouter.Route name="user" handler={Components.User} />
        </ReactRouter.Route>
        <NotFoundRoute handler={Components.NotFound} />
        <Redirect from="company" to="about" />
    </ReactRouter.Route>
)

ReactRouter.run routes, ReactRouter.HistoryLocation, (Handler, state) ->
    React.render(<Handler/>, document.getElementById('application'))