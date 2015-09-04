getTodoState = ->
    allTodos: app.TodoStore.getAll()
    areAllComplete: app.TodoStore.areAllComplete()

TodoApp = React.createClass
    getInitialState: -> getTodoState()
    componentDidMount: -> app.TodoStore.startTrackingChange(@_onChange)
    componentWillUnmount: -> app.TodoStore.stopTrackingChange(@_onChange)

    render: ->
        return (
            <div>
                <h1>Wei Shen Me?</h1>
                <TodoMainSection allTodos={@state.allTodos} areAllComplete={@state.areAllComplete} />
            </div>
        )

    _onChange: -> @setState(getTodoState())