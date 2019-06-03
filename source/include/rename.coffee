listKey = [
  'delay'
  'get'
  'post'
]
for key in listKey
  $["#{key}Async"] = $["#{key}_"]
