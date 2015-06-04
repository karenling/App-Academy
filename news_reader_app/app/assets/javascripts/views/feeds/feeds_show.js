NewsReader.Views.FeedsShow = Backbone.CompositeView.extend({

  template: JST['feeds/show'],

  events: {
    "click button.refresh": "refreshShow"
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.entries(), "add", this.addEntryView);
    this.listenTo(this.model.entries(), 'remove', this.removeEntryView);
    this.model.entries().each(this.addEntryView.bind(this));
  },

  addEntryView: function(entry) {
    var subview = new NewsReader.Views.EntryView({ model: entry });
    this.addSubview('.entries-list', subview);
  },

  removeEntryView: function(entry) {
    this.removeModelSubview('ul', entry);
  },

  render: function() {
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  refreshShow: function() {
    this.model.fetch({
      data: { "refresh": "True" },
    });
    // this.render();
    Backbone.history.navigate("#/feeds/" + this.model.id, { trigger: true });
  }

});
