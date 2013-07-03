App.module "Users", (Users, App, Backbone, Marionette, $, _, JST)->
  App.on 'initialize:before', ->
    App.headerLinks.push
      name: 'Users'
      path: 'users'
  Users.addInitializer ->
    Users.controller = new Controller
      region: App.mainContent
      
    App.router = new Router
      controller: Users.controller
    
    Backbone.history.start pushState: true
  
  class Router extends Marionette.AppRouter
    appRoutes:
      "users/new(/)": "newUser"
      "users/:id/edit(/)": "editUser"
      "users/:id(/)" : "showUser"
      "users(/)": "listUsers"
      "": "listUsers"
  
  class Controller extends Marionette.Controller
    initialize: (options)->
      @region = options.region
    listUsers: =>
      @collection ||=new App.Collections.Users
      $.when(@collection.fetch()).then =>
        @view = new App.Views.UsersIndex collection: @collection
        @region.show @view
    
    showUser: (id)=>
      $.when(@findUser(id)).then =>
        @view = new App.Views.UsersShow model: @model
        @region.show @view
    
    newUser: =>
      @view = new App.Views.UsersNew
      @region.show @view
      
    editUser: (id)=>
      $.when(@findUser(id)).then =>
        @view = new App.Views.UsersEdit model: @model
        @region.show @view
    
    findUser: (id)=>
      @model = @collection?.get(id) || new App.Models.User(id: id)
      $.when(@model.fetch())