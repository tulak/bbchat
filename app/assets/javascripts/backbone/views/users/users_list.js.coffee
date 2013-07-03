class App.Views.UsersList extends Marionette.ItemView
  template: 'users/list'
  tagName: 'tr'
  ui: 
    editButton: ".icon-edit"
    removeButton: ".icon-remove"
  events:
    "dblclick": "editUser"
    "click .icon-edit": "editUser"
    "click .icon-envelope": "openConversation"
    "click .icon-user": "setCurrentUser"
    "click .icon-remove": "removeUser"
    "click .name": "showUser"
  showUser: -> App.navigate @model, trigger: true
  editUser: -> App.navigate @model, action: 'edit', trigger: true
  removeUser: ->
    if confirm "Are you sure?"
      @model.destroy()
      App.navigate 'users'
  openConversation: ->
    App.Chat.conversations.add {to: @model.id, selected: true}, {silent: true}
  setCurrentUser: ->
    window.localStorage?.setItem('current_user', @model.id)
    App.current_user.id = @model.id
    App.current_user.fetch()