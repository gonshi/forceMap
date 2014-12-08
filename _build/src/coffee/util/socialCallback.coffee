class SocialCallback
  # PRIVATE
  watch: ->
    # native twitter btn
    window.twttr.ready ( twttr )->
      twttr.events.bind "tweet", ->
        _callback "tw"

    # native facebook btn
    window.fbAsyncInit = ->
      window.FB.init
        appId      : "", # TODO
        xfbml      : true,
        version    : "v2.2"
        window.FB.Event.subscribe "edge.create",
          ( response )->
            if response
              _callback "fb-like"

    _callback = ( type )->
      console.log type

module.exports = SocialCallback

getInstance = ->
  if !instance
    instance = new SocialCallback()
  return instance

module.exports = getInstance
###
  # call share
  window.FB.ui
    method: "share"
    href: "" # TODO
###
