TodoTextInput = React.createClass
  propTypes:
    className: React.PropTypes.string
    id: React.PropTypes.string
    placeholder: React.PropTypes.string
    onSave: React.PropTypes.func.isRequiredc
    value: React.PropTypes.string

  getInitialState: ->
    value: @props.value

  render: ->
    return (
      <input
        id={@props.id}
        className={@props.className}
        placeholder={@props.placeholder}
        onBlur={@_save}
        onChange={@_onChange}
        onKeyDown={@_onKeyDown}
        value={@state.value}
        autoFocus={true}
      />
    )

  _save: ->
    @props.onSave(@state.value)
    @setState {value: ''}

  _onChange: (event) ->
    @setState {value: event.target.value}

  _onKeyDown: (event) ->
    @_save() if event.keyCode is 13
