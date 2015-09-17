getTodoState = ->
    allTodos: App.TodoStore.getAll()
    areAllComplete: App.TodoStore.areAllComplete()

Components.TodoApp = React.createClass
    getInitialState: -> getTodoState()
    componentDidMount: -> App.TodoStore.startTrackingChange(@_onChange)
    componentWillUnmount: -> App.TodoStore.stopTrackingChange(@_onChange)

    render: ->
        return (
            <div>
                <h1>Wei Shen Me?</h1>
                <Components.TodoMainSection allTodos={@state.allTodos} areAllComplete={@state.areAllComplete} />
            </div>
        )

    _onChange: -> @setState(getTodoState())