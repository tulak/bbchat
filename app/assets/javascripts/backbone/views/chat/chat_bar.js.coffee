class App.Views.ChatBar extends Marionette.CollectionView
  tagName: 'ul'
  className: 'nav'
  getItemView: -> App.Views.ChatConversation
  collectionEvents:
    'reset': 'reRender'
  reRender: ->
    console.log('reset')
    @render()

  onShow: ->
    @children.forEach (c)->
      c.onShow?() 