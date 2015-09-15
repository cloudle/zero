_apps = {}

Wings.appStore = new EventEmitter()

Wings.appStore.emitChange = -> @emit 'change'
Wings.appStore.trackingChange = (callback) -> @on Wings.events.ChangeEvent, callback
Wings.appStore.stopTrackingChange = (callback) -> @removeListener Wings.events.ChangeEvent, callback

Wings.appStore.get = (id) -> _apps[id]
Wings.appStore.getAll = -> _apps