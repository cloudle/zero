@App = {}; @Wings = {}; @Components = {}

App.Dispatcher = new Flux.Dispatcher();

@Module = (namespace, specifications) ->
  namespace = generateNamespace(namespace)
  namespace.parent[namespace.node][key] = value for key, value of specifications

generateNamespace = (namespace) ->
  currentNamespace = @
  namespaceParts = namespace.split(".")
  for part in namespaceParts
    previousNamespace = currentNamespace; lastPart = part
    currentNamespace[part] = {} if !currentNamespace[part]
    currentNamespace = currentNamespace[part]
  return { parent: previousNamespace, node: lastPart }