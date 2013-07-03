class App.Collections.Messages extends Backbone.Collection
  model: App.Models.Message
  url: '/api/messages/channel'