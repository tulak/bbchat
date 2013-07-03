class App.Views.UsersIndex extends Marionette.CompositeView
  template: 'users/index'
  itemViewContainer: 'tbody'
  events:
    "click .new-user": "newUser"
  newUser: -> App.navigate "users/new", trigger: true
  getItemView: -> App.Views.UsersList
