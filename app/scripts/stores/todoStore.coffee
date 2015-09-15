_todos =
  "23123123":
    id: "23123123"
    complete: false
    text: "LNK<"

  "asdasdasd":
    id: "asdasdasd"
    complete: true
    text: "iDevices"

  "as1232123f":
    id: "as1232123f"
    complete: false
    text: "House"

ActionTypes = App.Constant.ActionTypes

create = (text) ->
  id = (+new Date() + Math.floor(Math.random() * 999999)).toString(36)
  _tods[id] = id: id, complete: false, text: text

update = (id, updates) -> helpers.merges(_todos[id], updates)
updateAll = (updates) -> helpers.merges(todo, updates) for key, todo of _todos; return
destroy = (id) -> delete _todos[id]
clearCompleted = -> delete _todos[id] for id, todo of _todos when todo.complete

App.TodoStore = helpers.merges new EventEmitter(),
  areAllComplete: -> (return false unless todo.complete) for id, todo of _todos; return true
  getAll: -> _todos
  emitChange: -> @emit App.events.Change
  startTrackingChange: (callback) -> @on App.events.Change, callback
  stopTrackingChange: (callback) -> @removeListener App.events.Change, callback

App.Dispatcher.register (action) ->
  if action.actionType is ActionTypes.TODO_CREATE
    if action.text.trim() isnt ''
      create(text)
      App.TodoStore.emitChange()
  else if action.actionType is ActionTypes.TODO_TOGGLE_COMPLETE_ALL
    if App.TodoStore.areAllComplete()
      updateAll {complete: false}
    else
      updateAll {complete: true}
    App.TodoStore.emitChange()
  else if action.actionType is ActionTypes.TODO_UNDO_COMPLETE
    update(action.id, {complete: false})
    App.TodoStore.emitChange()
  else if action.actionType is ActionTypes.TODO_COMPLETE
    update(action.id, {complete: true})
    App.TodoStore.emitChange()
  else if action.actionType is ActionTypes.TODO_UPDATE_TEXT
    text = action.text.trim()
    if text isnt ''
      update(action.id, {text: text})
      App.TodoStore.emitChange()
  else if action.actionType is ActionTypes.TODO_DESTROY
    destroy(action.id); App.TodoStore.emitChange()
  else if action.actionType is ActionTypes.TODO_DESTROY_COMPLETED
    clearCompleted(); App.TodoStore.emitChange()