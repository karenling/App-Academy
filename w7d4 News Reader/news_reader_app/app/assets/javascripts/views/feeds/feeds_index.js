NewsReader.Views.FeedsIndex = Backbone.View.extend({

  template: JST['feeds/index'],

  initialize: function () {
    this.listenTo(this.collection, "sync add", this.render);
    // this.listenTo(this.collection, "add", this.addToList);
  },

  addToList: function () {

  },

  render: function() {
    var feedsView = this;
    var content = this.template();
    this.$el.html(content);
    this.collection.each( function(feed) {
      var feedView = new NewsReader.Views.FeedsIndexItem({ model: feed });
      feedsView.$el.append(feedView.render().$el);
    });
    var formView = new NewsReader.Views.FeedsForm({ collection: this.collection});
    this.$el.append(formView.render().$el);
    return this;
  }

});
