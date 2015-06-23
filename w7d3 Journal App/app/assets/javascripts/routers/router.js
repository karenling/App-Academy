Journal.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "root",
    "posts/:id": "show"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.$content = this.$rootEl.find('.content');
    this.posts = this.posts || new Journal.Collections.Posts();
    this.posts.fetch( { reset: true } );
    this.indexView = new Journal.Views.PostsIndex ({ collection: this.posts });
    this.$rootEl.find('.sidebar').html(this.indexView.render().$el);
  },

  index: function () {
    this.indexView.render();
  },

  show: function (id) {
    var post = this.posts.getOrFetch(id);
    var showView = new Journal.Views.PostShow({ model: post });
    this.swapView(showView);
  },

  swapView: function (newView) {
    if (this.currentView) {
      this.currentView.remove();
    }
    this.currentView = newView;
    this.$content.html(newView.render().$el);
    return newView;
  },

  root: function () {
    this.currentView && this.currentView.remove();
    this.currentView = null;
    this.index();
  },
});
