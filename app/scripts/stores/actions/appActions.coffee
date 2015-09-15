ActionTypes = App.Constant.ActionTypes

App.Actions =
  changeAppName: (newAppName) ->
    App.Dispatcher.dispatch
      type: ActionTypes.CHANGE_APP_NAME
      nameName: newAppName