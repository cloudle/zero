RouteHandler = ReactRouter.RouteHandler
Link = ReactRouter.Link
Navigation = Components.Navigation
KernelAddon = Components.KernelAddon

Components.App = React.createClass
    getInitialState: ->
        appName: 'Zero!'
        applicationWidth: 0
        applicationHeight: 0

    componentDidMount: ->
        scope = @
        applicationSizeManager(scope)
        $(window).resize -> applicationSizeManager(scope)

    componentWillUnmount: -> $(window).off("resize", applicationSizeManager(@));

    render: ->
        <div id="container" className="dual-layout" style={height: @state.applicationHeight+'px'}>
            <Components.Navigation />
            <div className="detail-wrapper">
                <div className="dual-detail">
                    <RouteHandler />
                </div>
            </div>
            <Components.KernelAddon />
        </div>

applicationSizeManager = (scope) ->
    scope.setState
        applicationHeight: $(window).outerHeight()
        applicationWidth: $(window).outerWidth()