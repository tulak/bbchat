class App.Models.Conversation extends Backbone.Model
  localStorage: new Store "Conversations"
  defaults:
    selected: false
  
  initialize: (opts)->
    to = opts.to
    delete opts.to
    $.ajax 
      url: "/api/messages/channel_for/#{to}/#{App.current_user.id}"
      async: false
      success: (channel)=>
        @save {name: channel.name, channel_id: channel.id}, {silent: true}
        @collection.setSelected @ if @get('selected') == true