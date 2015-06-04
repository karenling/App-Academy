NewsReader.Routers.Feeds = Backbone.Router.extend({

  routes: {
    "": "index"
  },

  initialize: function (options) {
    this.feeds = new NewsReader.Collections.Feeds();
    this.$rootEl = options.$rootEl;
  },

  index: function () {
    this.feeds.fetch();
    var indexView = new NewsReader.Views.FeedsIndex({ collection: this.feeds });
    this.$rootEl.html(indexView.render().$el);
  }
});
