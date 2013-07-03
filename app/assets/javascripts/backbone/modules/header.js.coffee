App.module "Header", (Header, App, Backbone, Marionette, $, _, JST)->
  class Header.Link extends Backbone.Model
  class Header.Links extends Backbone.Collection 
    model: Header.Link
  
  class Header.LinkView extends Marionette.ItemView
    tagName: 'li'
    template: 'header/link'
    events:
      'click': 'link'
    link: =>
      App.navigate @model.get('path'), trigger: true
  
  class Header.View extends Marionette.CompositeView
    template: 'header/header'
    itemViewContainer: '.nav'
    itemView: Header.LinkView
  
  Header.on 'start', ->
    @links = new Header.Links App.headerLinks
    @view = new Header.View collection: @links
    App.header.show @view
    # console.log Header.links