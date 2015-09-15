@helpers = {}

helpers.keyMirror = (source) -> source[key] = key for key of source; source
helpers.merges = (source, exts...) -> source[key] = val for key, val of ext for ext in exts; source

@classNames = (source) ->
  result = ""
  result += "#{key} " for key, val of source when val
  result