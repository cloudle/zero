Templates.TodoMainSection = React.createClass
    propTypes:
        allTodos: React.PropTypes.object.isRequired
        areAllComplete: React.PropTypes.bool.isRequired

    render: ->
        return null if Object.keys(@props.allTodos).length < 1

        allTodos = @props.allTodos
        todos = []

        for key, obj of allTodos
            todos.push(<Templates.TodoItem key={key} todo={obj} />)

        return (
            <h1>Main section</h1>
            <section id="main">
                <input
                    id="toggle-all"
                    type="checkbox"
                    onChange={@_onToggleCompleteAll}
                    checked={if @props.areAllComplete then 'checked' else ''}
                />
                <label htmlFor="toggle-all">Mark all as complete</label>
                <ul id="todo-list">{todos}</ul>
            </section>
        )

    _onToggleCompleteAll: -> App.todoActions.toggleCompleteAll()