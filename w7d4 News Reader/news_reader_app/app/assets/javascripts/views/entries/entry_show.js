NewsReader.Views.EntryView = Backbone.View.extend({

  template: JST['entries/show'],
  tagName: 'li',

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function() {
    
    var content = this.template({ entry: this.model });
    this.$el.html(content);
    return this;
  },
});
