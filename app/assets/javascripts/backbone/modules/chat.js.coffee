App.module "Chat", (Chat, App, Backbone, Marionette, $, _, JST)->
  Chat.on "start", ->
    @conversations = new App.Collections.Conversations 
    $.when(@conversations.fetch()).then =>
      @view = new App.Views.ChatBar collection: @conversations
      App.chatBar.show @view