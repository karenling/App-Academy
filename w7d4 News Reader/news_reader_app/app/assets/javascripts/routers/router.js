NewsReader.Routers.Feeds = Backbone.Router.extend({

  routes: {
    "": "index",
    "feeds/:id": "feedShow"
  },

  initialize: function (options) {
    this.feeds = new NewsReader.Collections.Feeds();
    this.$rootEl = options.$rootEl;
  },

  index: function () {
    this.feeds.fetch();
    var indexView = new NewsReader.Views.FeedsIndex({ collection: this.feeds });
    this.$rootEl.html(indexView.render().$el);
  },

  feedShow: function (id) {
    var feed = this.feeds.getOrFetch(id);
    var showView = new NewsReader.Views.FeedsShow({ model: feed });
    this.$rootEl.html(showView.render().$el);
  }
});
