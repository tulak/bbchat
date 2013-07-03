class App.Views.ChatConversation extends Marionette.Layout
  tagName: 'li'
  template: 'chat/conversation'
  regions: 
    conversationRegion: ".conversation"
  
  events:
    'click .minimize': 'deselect'
    'click .close-conversation': 'closeConversation'
    'click .name': 'toggle'
  
  modelEvents:
    'change': 'render'
    
  c: ->
    # console.log "change: ", @model.get('name')
    
  onRender: =>
    # console.log "rendering:", @model.get('name'), @model.get('selected')
    if @model.get('selected') == true
      @$el.addClass 'active'
      @openMessages()
    else
      @$el.removeClass 'active' 
    
  openMessages: =>
    @messages = new App.Collections.Messages 
      # [
      #         author: 'Tulak'
      #         created_at: '11:50'
      #         body: "this is a message"
      #       ]
    # console.log('openMessages', @model.attributes)
    $.when(@messages.fetch data: $.param(channel_id: @model.get('channel_id'))).then =>
      @messagesView = new App.Views.ChatMessages collection: @messages, conversation: @model
      @conversationRegion.show @messagesView
  
  deselect: =>
    @model.save selected: false
    
  select: =>
    @model.collection.setSelected @model
  
  toggle: =>
    if @model.get('selected') == true
      @deselect()
    else
      @select()
  
  closeConversation: =>
    @model.destroy()