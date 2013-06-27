window.Bbchat =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
    alert 'Hello from Backbone!'

window.addEvent 'domready', ->
  Bbchat.initialize()
