class App.Views.UsersShow extends Marionette.ItemView
  template: 'users/show'
  events:
    'click #list-users': -> App.navigate 'users', trigger: true
    'click #edit-user': 'edit'
  edit: =>
    App.navigate @model, action: 'edit', trigger: true