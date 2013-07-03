class App.Views.ChatMessage extends Marionette.ItemView
  tagName: 'li'
  template: 'chat/message'
  onShow: ->
    @$el.addClass @model.get('direction')
    @model.collection.trigger 'new:message'