NewsReader.Views.FeedsIndex = Backbone.View.extend({

  template: JST['feeds/index'],

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function() {
    var feedsView = this;
    var content = this.template();
    this.$el.html(content);
    this.collection.each( function(feed) {
      var feedView = new NewsReader.Views.FeedsIndexItem({ model: feed });
      feedsView.$el.append(feedView.render().$el);
    });
    return this;
  }

});
