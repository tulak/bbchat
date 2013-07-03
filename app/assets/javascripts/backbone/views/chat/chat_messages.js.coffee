class App.Views.ChatMessages extends Marionette.CompositeView
  tagName: 'div'
  template: 'chat/messages'
  itemViewContainer: '.messages'
  getItemView: -> App.Views.ChatMessage
  events:
    "submit":"sendMessage"
  ui:
    msgField: "#message"
  collectionEvents:
    'new:message': 'scrollBottom'
  
  initialize: (args)->
    @conversation = args.conversation
    delete args.conversation
    super args
  
  scrollBottom: ->
    sh = @$('.messages').get(0).scrollHeight
    # console.log sh
    if sh > 0
      # @$('.messages').animate scrollTop: @$('.messages').get(0).scrollHeight, 100 
      # console.log 'scrolling', @$('.messages').get(0).scrollHeight
      @$('.messages').scrollTop @$('.messages').get(0).scrollHeight
  onShow: ->
    @scrollBottom()
    
    App.subscribePub "/messages/#{@conversation.get('channel_id')}", (data, options)=>
      @collection.add data, wait: true unless parseInt(data.user_id) == parseInt(App.current_user.id)
    
  sendMessage: (e)->
    e.preventDefault()
    # console.log @conversation
    msg = @collection.create 
      body: @ui.msgField.val()
      user_id: App.current_user.id
      author: App.current_user.get('name')
      channel_id: @conversation.get('channel_id')
    ,
      wait: true
    @ui.msgField.val('')