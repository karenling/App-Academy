NewsReader.Views.FeedsIndexItem = Backbone.View.extend({

  template: JST['feeds/index_item'],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click button.delete-feed": "deleteFeed"
  },

  render: function() {
    var content = this.template({ feed: this.model });
    this.$el.html(content);

    return this;
  },

  deleteFeed: function(event) {
    event.preventDefault();
    this.remove();
    this.model.destroy();
  }

});
