TodoItem = React.createClass
    propTypes:
        todo: React.PropTypes.object.isRequired

    getInitialState: ->
        isEditing: false

    render: ->
        todo = @props.todo
        if @state.isEditing
            input = <TodoTextInput className="edit" onSave={@_onSave} value={todo.text} />

        return (
            <li className={classNames({'completed': todo.complete, 'editing': this.state.isEditing })} key={todo.id}>
                <div className="view">
                    <input className="toggle" type="checkbox" checked={todo.complete} onChange={@_onToggleComplete} />
                    <label onDoubleClick={@onDoubleClick}>{todo.text}</label>
                    <button className="destroy" onClick={@_onDestroyClick} >X</button>
                </div>
                {input}
            </li>
        )

    _onToggleComplete: ->
        app.todoActions.toggleComplete(@props.todo)
    _onDoubleClick: -> @setState({isEditing: true})
    _onSave: (text) ->
        app.todoActions.updateText(@props.todo.id, text)
        @setState({isEditing: false})
    _onDestroyClick: ->
        app.todoActions.destroy(@props.todo.id)