RouteHandler = ReactRouter.RouteHandler
Link = ReactRouter.Link

App = React.createClass
    getInitialState: ->
        appName: 'Zero!'
    render: ->
        <div>
            <Navigation />
            <div id="container" className="dual-content">
                <div className="left-side-pane"></div>
                <div className="dual-content-wrapper">
                    <div className="right-side-pane">
                        <RouteHandler />
                    </div>
                </div>
            </div>

            <Footer />
        </div>