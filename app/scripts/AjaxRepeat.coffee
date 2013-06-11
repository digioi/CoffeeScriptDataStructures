#AjaxRepeat.get(url).when(function(returnVal){....Do Stuff.....})
'use strict'

# Promise Maker Closure that Douglas Crockford demoed in 2010
# re-written in coffeescript by myself(Mike DiGioia)
makePromise = ->
  status   = 'unresolved'
  outcome  = undefined
  waiting  = []
  dreading = []

  vouch = (deed, func)->
    switch (status)
      when 'unresolved'
        (if deed is 'fulfilled' then waiting else dreading).push(func)
      when deed
        func(outcome)

  resolve = (deed, value)->
    if (status is not 'unresolved')
      throw new Error('The promise has already been resolved:' + status);
    status = deed
    outcome = value
    funcs = _getFunctions(deed)
    if funcs?.length?
      _call(func) for func in funcs
      waiting = null
      dreading = null

  _getFunctions = (deed)->
    if deed is 'fulfilled'
      waiting 
    else
      dreading

  _call = (func)->
    try
      func(outcome)
    catch ignore

  {
    when:    (func)   -> vouch('fulfilled', func)
    fail:    (func)   -> vouch('smashed', func)
    fulfill: (value)  -> resolve('fulfilled', value)
    smash:   (string) -> resolve('smashed', string)
    status:           -> status
  }

class AjaxRepeat
  constructor: (@api_url, options)->
    @promise = makePromise()
    @timer   = options['timer'] 
    @timer   = 1000 unless @timer? # 1 second
    @counter = options['counter'] || 5
    @_setAjaxCall options['method'] || 'get'
    @run()
  
  # Class Methods
  @get: (url,options)->    @_method_call(url, 'get', options)
  @post: (url,options)->   @_method_call(url, 'post', options)
  @delete: (url,options)-> @_method_call(url, 'delete', options)
  @put: (url,options)->    @_method_call(url, 'put', options)
  @_method_call: (url, method, options)-> 
    options ||= {}
    options['method'] = method
    new AjaxRepeat(url, options)

  # Instance Methods
  when:     (cb)-> 
    @promise.when(cb)
    @
  fail:     (cb)-> 
    @promise.fail(cb)
    @
  run: ->
    setTimeout(@_run, 0) #run immediately, _run will call again on error

  ###########
  # Helpers #
  ###########
  _run: =>
    if @counter <= 0
      @promise.smash('Failed to Reach API') #Message to send to the failed message 
    else 
      @counter -= 1
      @ajaxCall(@api_url)
        .success((results)=> @promise.fulfill(results))
        .error(=> @_repeatCall())
  _repeatCall: ->
    setTimeout((=>@run()), @timer)
  _setAjaxCall: (method)->
    @ajaxCall = switch method #currently uses jQuery but has more potential then using the jquery plugin
      when 'get'    then $.get
      when 'post'   then $.post
      when 'delete' then $.delete
      when 'put'    then $.put
  
window.AjaxRepeat = AjaxRepeat