class App.Views.UsersEdit extends Marionette.ItemView
  template: 'users/edit'
  ui: 
    nameField: '#name'
    emailField: '#email'
    passwordField: '#password'
  events:
    'submit form': 'save'
    'click .cancel': -> App.navigate 'users', trigger: true
  
  save: (e)=>
    e.preventDefault()
    $.when(@model.save({
      name: @ui.nameField.val()
      email: @ui.emailField.val()
      password: @ui.passwordField.val()
    })).then =>
      App.navigate @model, trigger: true
