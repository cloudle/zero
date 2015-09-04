ActionTypes = app.Constant.ActionTypes

app.todoActions =
  create: (text) ->
    app.Dispatcher.dispatch
      actionType: ActionTypes.TODO_CREATE
      text: text

  updateText: (id, text) ->
    app.Dispatcher.dispatch
      actionType: ActionTypes.TODO_UPDATE_TEXT
      id: id
      text: text

  toggleComplete: (todo) ->
    actionType = if todo.complete then ActionTypes.TODO_UNDO_COMPLETE else ActionTypes.TODO_COMPLETE
    app.Dispatcher.dispatch
      actionType: actionType
      id: todo.id

  toggleCompleteAll: ->
    app.Dispatcher.dispatch
      actionType: ActionTypes.TODO_TOGGLE_COMPLETE_ALL

  destroy: (id) ->
    app.Dispatcher.dispatch
      actionType: ActionTypes.TODO_DESTROY
      id: id

  destroyCompleted: ->
    app.Dispatcher.dispatch
      actionType: ActionTypes.TODO_DESTROY_COMPLETED