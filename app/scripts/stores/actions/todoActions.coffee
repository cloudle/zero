ActionTypes = App.Constant.ActionTypes

App.todoActions =
  create: (text) ->
    App.Dispatcher.dispatch
      actionType: ActionTypes.TODO_CREATE
      text: text

  updateText: (id, text) ->
    App.Dispatcher.dispatch
      actionType: ActionTypes.TODO_UPDATE_TEXT
      id: id
      text: text

  toggleComplete: (todo) ->
    actionType = if todo.complete then ActionTypes.TODO_UNDO_COMPLETE else ActionTypes.TODO_COMPLETE
    App.Dispatcher.dispatch
      actionType: actionType
      id: todo.id

  toggleCompleteAll: ->
    App.Dispatcher.dispatch
      actionType: ActionTypes.TODO_TOGGLE_COMPLETE_ALL

  destroy: (id) ->
    App.Dispatcher.dispatch
      actionType: ActionTypes.TODO_DESTROY
      id: id

  destroyCompleted: ->
    App.Dispatcher.dispatch
      actionType: ActionTypes.TODO_DESTROY_COMPLETED