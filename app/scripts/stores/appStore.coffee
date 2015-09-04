_apps = {}

zero.appStore = new EventEmitter()

zero.appStore.emitChange = -> @emit 'change'
zero.appStore.trackingChange = (callback) -> @on zero.events.ChangeEvent, callback
zero.appStore.stopTrackingChange = (callback) -> @removeListener zero.events.ChangeEvent, callback

zero.appStore.get = (id) -> _apps[id]
zero.appStore.getAll = -> _apps