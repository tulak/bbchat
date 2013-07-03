class App.Views.UsersNew extends Marionette.ItemView
  template: 'users/new'
  ui: 
    nameField: '#name'
    emailField: '#email'
    passwordField: '#password'
  events:
    'submit form': 'save'
    'click .cancel': -> App.navigate 'users', trigger: true
  
  save: (e)=>
    e.preventDefault()
    @model = new App.Models.User
      name: @ui.nameField.val()
      email: @ui.emailField.val()
      password: @ui.passwordField.val()
    $.when(@model.save()).then =>
      App.navigate @model, trigger: true
