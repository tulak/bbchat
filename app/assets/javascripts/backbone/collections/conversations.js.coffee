class App.Collections.Conversations extends Backbone.Collection
  model: App.Models.Conversation
  localStorage: new Backbone.LocalStorage("Conversations"),
  setSelected: (model)=>
    @where(selected: true).forEach (m) =>
      # console.log model.get('name'), '-->',m.get('name'), m.get('selected')
      m.save selected: false unless m == model
    model.save selected: true
    
  add: (model)=>
    return false if model.to == App.current_user.id
    isDupe = @any (m)-> 
      m.get('to') == model.to
    if not isDupe
      super(model)
    else
      @setSelected @findWhere(to: model.to)
      false