ActionTypes = app.Constant.ActionTypes

app.Actions =
  changeAppName: (newAppName) ->
    app.Dispatcher.dispatch
      type: ActionTypes.CHANGE_APP_NAME
      nameName: newAppName

