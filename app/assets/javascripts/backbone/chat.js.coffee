window.App = new Marionette.Application
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  headerLinks: []
  navigate: (route, options)->
    options || (options = {})
    action = options.action
    delete options.action
    if route instanceof Backbone.Model
      model = route
      path = InflectionJS.tableize(model.constructor.name)
      route = "#{path}/#{model.id}"
      route +="/#{action}" if action
    Backbone.history.navigate route, options 

App.addInitializer ->
  cid = window.localStorage?.getItem('current_user')
  App.current_user = new App.Models.User id: cid||1
  $.when(App.current_user.fetch()).then =>
    view = new App.Views.UsersCurrentUser model: App.current_user
    App.sidebar.show view
    
App.subscribePub = (channel, callback)->
  options = App.privatePubOptions
  options['timestamp'] = (new Date()).getTime() * 1000 if timestamp?
  s = "#{Rails.private_pub_secret_token}#{channel}#{options['timestamp']}"
  options['signature'] = SHA1(s)
  options['channel'] = channel
  PrivatePub.sign(options)
  PrivatePub.subscribe channel, callback

App.addRegions
  mainContent: "#main"
  sidebar: "#sidebar"
  header: "#header"
  chatBar: ".chat-bar"
  
Backbone.Marionette.Renderer.render = (template, data)->
  throw "Template '" + template + "' not found!" if (!JST[template])
  JST[template](data)

$ ->
  App.start()
  
App.privatePubOptions = 
  "server": "http://localhost:9292/faye"
  "timestamp": (new Date()).getTime() * 1000