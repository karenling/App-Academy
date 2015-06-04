NewsReader.Views.FeedsShow = Backbone.View.extend({

  template: JST['feeds/show'],
  tagName: "ul",

  events: {
    "click button.refresh": "refreshShow"
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function() {
    var content = this.template({ feed: this.model });
    this.$el.html(content);

    return this;
  },

  refreshShow: function() {
    // this.model.fetch();
    // this.render();
    Backbone.history.navigate("#/feeds/" + this.model.id, { trigger: true });
  }

});
