class App.Views.UsersCurrentUser extends Marionette.ItemView
  template: 'users/current_user'
  modelEvents:
    'change': 'render'
